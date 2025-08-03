using Microsoft.AspNetCore.Mvc;
using System.DirectoryServices;
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
            string ldapPath = "LDAP://172.16.16.12/DC=mctvt,DC=edu,DC=sa";
            string domain = "mctvt.edu.sa";
            string domainAndUsername = $"{domain}\\{request.Username}";
            try
            {
                using (var entry = new DirectoryEntry(ldapPath, domainAndUsername, request.Password))
                {
                    using (var searcher = new DirectorySearcher(entry))
                    {
                        searcher.Filter = $"(SAMAccountName={request.Username})";
                        searcher.PropertiesToLoad.Add("cn");
                        var result = searcher.FindOne();
                        if (result == null)
                        {
                            return Unauthorized(new { message = "Invalid username or password." });
                        }
                        var userName = result.Properties["cn"].Count > 0 ? result.Properties["cn"][0]?.ToString() : null;
return Ok(new { message = "Login successful.", name = userName });
                    }
                }
            }
            catch
            {
                return Unauthorized(new { message = "Invalid username or password." });
            }
        }
    }

    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
