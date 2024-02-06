using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class BookingEntity
    {
        public int Id { get; set; }
        public DateTime DateBooking { get; set; }
        public int? CustomerId { get; set; }
        public int? SeatId { get; set; }
        public int? BillboardId { get; set; }

        public virtual BillboardEntity? Billboard { get; set; }
        public virtual CustomerEntity? Customer { get; set; }
        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual SeatEntity? Seat { get; set; }
    }
}
