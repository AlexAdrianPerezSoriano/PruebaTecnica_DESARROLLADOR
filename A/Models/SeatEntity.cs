using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class SeatEntity
    {
        public SeatEntity()
        {
            BookingEntities = new HashSet<BookingEntity>();
        }

        public int Id { get; set; }
        public short Number { get; set; }
        public short RowNumber { get; set; }
        public int? RoomId { get; set; }

        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual RoomEntity? Room { get; set; }
        public virtual ICollection<BookingEntity> BookingEntities { get; set; }
    }
}
