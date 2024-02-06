using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class BillboardEntity
    {
        public BillboardEntity()
        {
            BookingEntities = new HashSet<BookingEntity>();
        }

        public int Id { get; set; }
        public DateTime DateBillboard { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public int? MovieId { get; set; }
        public int? RoomId { get; set; }

        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual MovieEntity? Movie { get; set; }
        public virtual RoomEntity? Room { get; set; }
        public virtual ICollection<BookingEntity> BookingEntities { get; set; }
    }
}
