using System;
using System.Collections.Generic;

namespace A.Models
{
    public partial class MovieEntity
    {
        public MovieEntity()
        {
            BillboardEntities = new HashSet<BillboardEntity>();
        }

        public int Id { get; set; }
        public string NameMovie { get; set; } = null!;
        public int Genre { get; set; }
        public short AllowedAge { get; set; }
        public short LengthMinutes { get; set; }

        public virtual BaseEntity IdNavigation { get; set; } = null!;
        public virtual ICollection<BillboardEntity> BillboardEntities { get; set; }
    }
}
