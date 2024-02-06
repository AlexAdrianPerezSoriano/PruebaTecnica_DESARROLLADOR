using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class RoomEntity
    {
        public RoomEntity()
        {
            BillboardEntities = new HashSet<BillboardEntity>();
            SeatEntities = new HashSet<SeatEntity>();
        }

        public int Id { get; set; }
        public string NameRoom { get; set; } = null!;
        public short Number { get; set; }

        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual ICollection<BillboardEntity> BillboardEntities { get; set; }
        public virtual ICollection<SeatEntity> SeatEntities { get; set; }
    }
}
