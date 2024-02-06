using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class CustomerEntity
    {
        public CustomerEntity()
        {
            BookingEntities = new HashSet<BookingEntity>();
        }

        public int Id { get; set; }
        public string DocumentNumber { get; set; } = null!;
        public string NameCustomer { get; set; } = null!;
        public string Lastname { get; set; } = null!;
        public short Age { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }

        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual ICollection<BookingEntity> BookingEntities { get; set; }
    }
}
