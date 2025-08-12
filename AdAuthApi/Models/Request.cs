using System.ComponentModel.DataAnnotations;

namespace AdAuthApi.Models
{
    public class Request
    {
        public int Id { get; set; }

        [Required]
        public string? RequesterName { get; set; }

        [Required]
        public string? Department { get; set; }

        public string? OfficeNumber { get; set; }

        public string? TransferNumber { get; set; }

        [Required]
        public string? RequestType { get; set; } // e.g., "IT Support" or "Maintenance"

        [Required]
        public string? IssueType { get; set; } // e.g., "Network Issue" or "Electrical Maintenance"

        [Required]
        public string? Description { get; set; }

        public DateTime Date { get; set; } = DateTime.Now;

        public string Status { get; set; } = "New";
    }
}
