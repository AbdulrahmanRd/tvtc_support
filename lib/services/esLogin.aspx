<%@ Page Language="VB" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    Dim initLDAPPath As String = "DC=mctvt,DC=edu,DC=sa"
    Dim initLDAPServer As String = "172.16.16.12"
    Dim initShortDomainName As String = "mctvt.edu.sa"

    Class LoginRequest
        Public username As String
        Public password As String
    End Class

    Class LoginResponse
        Public success As Boolean
        Public message As String
        Public name As String
        Public role As String
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Response.ContentType = "application/json"
        Response.AddHeader("Access-Control-Allow-Origin", "*")

        If Request.HttpMethod = "POST" Then
            Dim reader As New System.IO.StreamReader(Request.InputStream)
            Dim body As String = reader.ReadToEnd()

            Dim js As New JavaScriptSerializer()
            Dim data As LoginRequest = js.Deserialize(Of LoginRequest)(body)

            Dim result As New LoginResponse()
            If String.IsNullOrEmpty(data.username) OrElse String.IsNullOrEmpty(data.password) Then
                result.success = False
                result.message = "Username or password missing."
                Response.Write(js.Serialize(result))
                Return
            End If

            Dim strCommu As String = "LDAP://" & initLDAPServer & "/" & initLDAPPath
            Dim domainUser As String = initShortDomainName & "\" & data.username
            Dim entry As New DirectoryEntry(strCommu, domainUser, data.password)

            Try
                Dim search As New DirectorySearcher(entry)
                search.Filter = "(SAMAccountName=" & data.username & ")"
                search.PropertiesToLoad.Add("cn")

                Dim adResult As SearchResult = search.FindOne()

                If adResult Is Nothing Then
                    result.success = False
                    result.message = "اسم المستخدم او كلمة المرور غير صحيحة"
                    Response.Write(js.Serialize(result))
                    Return
                End If

                Dim fullName As String = adResult.Properties("cn")(0).ToString()
                result.name = fullName
                result.success = True
                result.message = "تم تسجيل الدخول بنجاح"

                ' Check DB role
                Dim connStr1 As String = "Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\edb.mdf;Integrated Security=True;User Instance=True"
                Dim connStr2 As String = "Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\TecAff.mdf;Integrated Security=True;User Instance=True"

                Using conn1 As New SqlConnection(connStr1), conn2 As New SqlConnection(connStr2)
                    conn1.Open()
                    conn2.Open()

                    Dim cmd1 As New SqlCommand("SELECT account_name FROM accounts WHERE account_name = @user", conn1)
                    cmd1.Parameters.AddWithValue("@user", data.username)
                    Dim existsInIT As Boolean = cmd1.ExecuteScalar() IsNot Nothing

                    Dim cmd2 As New SqlCommand("SELECT account_name FROM accounts WHERE account_name = @user", conn2)
                    cmd2.Parameters.AddWithValue("@user", data.username)
                    Dim existsInTech As Boolean = cmd2.ExecuteScalar() IsNot Nothing

                    If existsInIT Then
                        result.role = "it"
                    ElseIf existsInTech Then
                        result.role = "technical"
                    Else
                        result.role = "general"
                    End If
                End Using

            Catch ex As Exception
                result.success = False
                result.message = "خطأ في الاتصال بالدليل النشط"
            End Try

            Response.Write(js.Serialize(result))
        Else
            Response.StatusCode = 405
            Response.Write("{""error"":""Method Not Allowed""}")
        End If
    End Sub
</script>
