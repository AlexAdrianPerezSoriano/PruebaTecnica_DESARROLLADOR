using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class BaseEntity
    {
        public int Id { get; set; }
        public bool? Status { get; set; }

        public virtual BillboardEntity? BillboardEntity { get; set; }
        public virtual BookingEntity? BookingEntity { get; set; }
        public virtual CustomerEntity? CustomerEntity { get; set; }
        public virtual MovieEntity? MovieEntity { get; set; }
        public virtual RoomEntity? RoomEntity { get; set; }
        public virtual SeatEntity? SeatEntity { get; set; }
    }
}
