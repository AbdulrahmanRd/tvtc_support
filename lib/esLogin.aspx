
<%@ Assembly Name="System.DirectoryServices, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.DirectoryServices"%>
<%@ Import Namespace="System.Security.Cryptography"%>
<%@ Import Namespace="System.Text"%>
<%@ Page Language="VB" %>
<script runat="server">
	
   ' Dim dSp As DirectoryServices.PropertyValueCollection
    
    Dim initLDAPPath As String = "DC=mctvt,DC=edu,DC=sa"
    Dim initLDAPServer As String = "172.16.16.12"
    Dim initShortDomainName As String = "mctvt.edu.sa"
    Dim strErrMsg As String

    Public Function MD5(ByVal strString As String) As String
        Dim ASCIIenc As New ASCIIEncoding
        Dim strReturn As String
        Dim ByteSourceText() As Byte = ASCIIenc.GetBytes(strString)
        Dim Md5Hash As New MD5CryptoServiceProvider
        Dim ByteHash() As Byte = Md5Hash.ComputeHash(ByteSourceText)

        strReturn = ""

        For Each b As Byte In ByteHash
            strReturn = strReturn & b.ToString("x2")
        Next

        Return strReturn

    End Function
    
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)     
       
        '   Dim conn As New SqlConnection("Data Source=E-SERVICES\SQLEXPRESS;AttachDbFilename=|DataDirectory|\edb.mdf;Integrated Security=True;User Instance=True")
        '   Dim connect As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\TecAff.mdf;Integrated Security=True;User Instance=True")
       
        '   conn.Open()
        'connect.Open()
        Session("strUser") = txtUser.Text
        '  connect.Close()
        'conn.Close()
    End Sub
	

   
    
    'Public Function ExtractUserName(ByVal path As String) As String
    '    Dim userPath As String() = path.Split(New Char() {"\"c})
    '    Return userPath((userPath.Length - 1))
    'End Function
    
    Protected Sub btn_login_Click(ByVal sender As Object, ByVal e As System.EventArgs)
      
        Dim conn As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\edb.mdf;Integrated Security=True;User Instance=True")
      
        Dim connect As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\TecAff.mdf;Integrated Security=True;User Instance=True")
       
        conn.Open()
        connect.Open()
       
        
        
        
        ''look for the name in AD
        'Dim DomainAndUsername As String
        'Dim strCommu As String
        'Dim flgLogin As Boolean = False
        'strCommu = "LDAP://" & initLDAPServer & "/" & initLDAPPath
        'DomainAndUsername = initShortDomainName & "\" & txtuser.Text

        'Dim entry As New DirectoryEntry(strCommu, DomainAndUsername, txtpwd.Text)

        ''Try
        'Dim search As New DirectorySearcher(entry)
        'Dim result As SearchResult
        ''Dim loginName As String
        ''Dim givenName As String
        ''Dim surName As String        
        'search.PropertiesToLoad.Add("givenName")
        'search.Filter = "(SAMAccountName=" + txtuser.Text + ")"
        ''search.Filter = String.Format("(&(SAMAccountName={0}) & (givenName={1})(sn={2}))", ExtractUserName(LoginName), givenName, surName)
        'search.PropertiesToLoad.Add("cn")
            
        'result = search.FindOne()
            
        ''lbl1.Text = 
        '' Response.Write(result.Properties("cn").ToString)
        'If result Is Nothing Then
        '    flgLogin = False
        '    strErrMsg = "الرجاء التأكد من اسم المستخدم او كلمة المرور "
       
        'Else
        Dim DomainAndUsername As String = ""
        Dim strCommu As String
        Dim flgLogin As Boolean = False
        strCommu = "LDAP://" & initLDAPServer & "/" & initLDAPPath
        DomainAndUsername = initShortDomainName & "\" & txtuser.Text

        Dim entry As New DirectoryEntry(strCommu, DomainAndUsername, txtpwd.Text)

        Try
            Dim search As New DirectorySearcher(entry)
            Dim result As SearchResult
         
            'search.PropertiesToLoad.Add("givenName")
            search.Filter = "(SAMAccountName=" + txtuser.Text + ")"
            search.PropertiesToLoad.Add("cn")


            result = search.FindOne()
            'lbl1.Text = 
            Response.Write(result.Properties.Item("cn").ToString)
            If result Is Nothing Then
                flgLogin = False
                strErrMsg = "الاسم غير موجود"
                
            Else
                            
                lbl1.Text = result.Properties("cn")(0).ToString
                
                flgLogin = True
               
                
                'connect to DB to select IT admin
        
          
                Dim cmd As New SqlCommand("SELECT [account_name] FROM [accounts] WHERE ([account_name] = @account_name)", conn)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@account_name", Session("strUser"))
                Dim da As New SqlDataAdapter(cmd)
                Dim dt As New DataTable
                da.Fill(dt)
        
                
                'connect to DB to select technical affairs admin
        
           
                Dim comd As New SqlCommand("SELECT account_name FROM accounts WHERE (account_name = @account_name)", connect)
                comd.CommandType = CommandType.Text
                comd.Parameters.AddWithValue("@account_name", Session("strUser"))
                Dim sda As New SqlDataAdapter(comd)
                Dim sdt As New DataTable
                sda.Fill(sdt)

                
                'find IT & user in database
                Dim coun As Integer
                coun = sdt.Rows.Count
                
                Dim c As Integer
                c = dt.Rows.Count
        
        
                If c > 0 Then
                    Session("getname") = lbl1.Text
                    Session("strUser") = lbl1.Text
                    Response.Redirect("~/electronic_services/IT/welcome.aspx")
                ElseIf coun > 0 Then
                    Session("getname") = lbl1.Text
                    Session("strUser") = lbl1.Text
                    Response.Redirect("~/electronic_services/technicalaffairs/default.aspx")
                    
                Else
 
                    Session("getname") = lbl1.Text
                    Session("strUser") = lbl1.Text
                    Response.Redirect("~/electronic_services/Default.aspx")
                
                End If
                
                
                da.Dispose()
                dt.EndLoadData()
                
                conn.Close()
                connect.Close()
              
            End If
        
        
           
            
        Catch ex As Exception
            flgLogin = False
            strErrMsg = "الرجاء التأكد من اسم المستخدم او كلمة المرور "
        End Try
		

        If flgLogin = True Then
            Me.lbDisplay.Text = "Welcome " & txtuser.Text
        Else
            Me.lbDisplay.Text = strErrMsg
        End If
        
        conn.Close()
        connect.Close()
    End Sub
    
    
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html dir="rtl" >
    <head>
   
        <title>نظام الدعم الفني</title>
<%--    <meta name="google-site-verification" content="F6sy_uq05RXWhbfQY0bWlaV6HiM7VYqX_KTUn0GXy60" />​ --%>    

         <meta charset="utf-8">
  <meta name="viewport" content="device-width, initial-scale=1">

   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 <link href="https://fonts.googleapis.com/css2?family=Almarai&display=swap" rel="stylesheet">




<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="description" content="Expand, contract, animate forms with jQuery wihtout leaving the page" />
        <meta name="keywords" content="expand, form, css3, jquery, animate, width, height, adapt, unobtrusive javascript"/>
		<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
     
        <link href="App_Themes/Theme1/style.css" rel="stylesheet" type="text/css" />
      
        <style type="text/css">
            .style1
            {
                color: #FF0000;
                font-size: medium;
               
                 font-family:Times New Roman;
               
            }
            .style2
            {
                color: #333333;
                font-family:Times New Roman;
                   background-color:#1e7166;
            }
           
          
            .style3
            {
                width: 100%;
                font-family:Times New Roman;
                background-color:#4c4c4c;
            }
           
          
            .style4
            {
                width: 75px;
                font-family:Times New Roman;
                 
            }
           
           
            .style5
            {
               color: #333333;
              
                font-family:Times New Roman;
                font-weight:bold;
            }
          
            .style6
            {
               color: #333333;
                font-family:Times New Roman;
                font-weight:bold;
                font-size: medium;
            
            }
            .style21
            {
                color:#0275d8;
font-family:'Times New Roman';
font-weight:bold;
font-size:medium;

            }
            .style50
            {
 
                font-family:Times New Roman;
                font-weight:bold;
                font-size: medium;
                background-color:#1e7166;
            }
            .style1bg
            {
                 background-color:#f7f7f7;
            
            }
              .auto-style8 {
            font-family: Almarai;
            font-size: xx-large;
            text-align: center;
        }
              .auto-stylesmall {
            font-family: Almarai;
            font-size:small;
            text-align: center;
        }
        </style>
      
        </head>
    <body class="style1bg">
        <form id="form1" runat="server">
    <center>
    <div class="wrapper">
         <div class="auto-style10">
    <br />
          
    <asp:Image ID="Image1" runat="server" ImageUrl="~/imgs/tvtc_logo3.png" Width="77px" />
    <br />  

              <br />
         
            
              <h3 align="center" class="auto-style8">الإدارة العامة للتدريب التقني والمهني بمنطقة 
              المدينة المنورة</h3>
             <p align="center" >&nbsp;</p>

             </div>

             <h1 align="center"class="auto-style8">نظام الدعم الفني<br />    </h1>
         
           
		
          <div align="center"><span class="style"><span class="style1">
              <strong >لاستخدام النظام قم بتسجيل الدخول بواسطة بيانات حسابك على الشبكه الداخليه</strong></span><br>
          <br>
          </span>          </div>
          <div class="content">
				<div id="form_wrapper" class="form_wrapper">
	<h3 align="center" style="background-color:#4c4c4c;" class="auto-stylesmall" >تسجيل الدخول</h3>
						<div dir="rtl">
							<label class="auto-stylesmall"><strong>اسم المستخدم:</strong></label>
                            <asp:TextBox ID="txtuser" runat="server"></asp:TextBox>
							<br />
						</div>
						<div>
							<label class="auto-stylesmall"><strong >كلمة المرور: </strong></label>
                            <asp:TextBox ID="txtpwd"  TextMode="Password" runat="server" ></asp:TextBox>
							<label ><strong>
    <asp:Label ID="lbDisplay" runat="server" ForeColor="Red" Font-Size="Medium" Font-Names="Times New Roman"></asp:Label>
 
                            <br />
 
 
 
                            </strong></label></div>
			    <div class="bottom" align="center">
                     <table class="style3" >
                         <tr>
                             <td align="center" class="style4">
                             </td>
                             <td align="center">
                     <asp:Button ID="btn_login" Text="دخول" CssClass="btn-primary" onclick="btn_login_Click" runat="server" /> 
                             </td>
                         </tr>
                     </table>
                     <div class="clear"></div>
			     </div>
                        
   
                   
	
				</div>
				<div class="clear">
                    <asp:Label ID="lbl1" runat="server"></asp:Label>
                    
        </br>
</div>
		
		</div>
        </div>
       
                
    </center>
		
		

        </form>
		
		<footer>

  <div class="footer-copyright text-center text-black-50 py-3"><p class="text-secondary">© 2021 Copyright: تقنية المعلومات</p>
    
  </div>
		</footer>
		

</body>

     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 <link href="https://fonts.googleapis.com/css2?family=Almarai&display=swap" rel="stylesheet">

</html>
