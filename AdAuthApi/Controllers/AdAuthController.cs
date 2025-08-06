using Microsoft.AspNetCore.Mvc;
using System.DirectoryServices.Protocols;
using System.Net;
using System.Threading.Tasks;

namespace AdAuthApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AdAuthController : ControllerBase
    {
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            string ldapHost = "172.16.16.12";
            int ldapPort = 389; // default LDAP port
            string domain = "mctvt.edu.sa";
            string userDn = $"{request.Username}@{domain}";
            string searchBase = "DC=mctvt,DC=edu,DC=sa";

            try
            {
                using (var connection = new LdapConnection(new LdapDirectoryIdentifier(ldapHost, ldapPort)))
                {
                    // Set connection options
                    connection.SessionOptions.ProtocolVersion = 3; // LDAP v3
                    connection.AuthType = AuthType.Basic;
                    
                    // Bind with the user credentials
                    if (request.Password != null && request.Username != null)
                    {
                        var credentials = new NetworkCredential($"{request.Username}@{domain}", request.Password);
                        connection.Bind(credentials);
                    }
                    else
                    {
                        return BadRequest(new { message = "Username and password are required" });
                    }

                    // Search for the user to get CN (display name)
                    var searchFilter = $"(sAMAccountName={request.Username})";
                    var searchRequest = new SearchRequest(
                        searchBase,
                        searchFilter,
                        SearchScope.Subtree,
                        new[] { "cn" }
                    );

                    var searchResponse = (SearchResponse)connection.SendRequest(searchRequest);
                    string userName = "";

                    if (searchResponse.Entries.Count > 0)
                    {
                        var entry = searchResponse.Entries[0];
                        if (entry.Attributes["cn"] != null && entry.Attributes["cn"].Count > 0)
                        {
                            userName = entry.Attributes["cn"][0].ToString();
                        }
                    }

                    return Ok(new { message = "Login successful.", name = userName });
                }
            }
            catch (DirectoryOperationException ex)
            {
                return Unauthorized(new { message = "Invalid username or password.", error = ex.Message });
            }
        }

        public class LoginRequest
        {
            public string? Username { get; set; }
            public string? Password { get; set; }
        }
    }
}