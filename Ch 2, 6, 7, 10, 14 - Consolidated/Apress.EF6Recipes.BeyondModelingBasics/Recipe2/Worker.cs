using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.BeyondModelingBasics.Recipe2
{
    [Table("Worker", Schema="Chapter6")]
    public class Worker
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int WorkerId { get; set; }
        public string Name { get; set; }

        [ForeignKey("WorkerId")]
        public virtual ICollection<WorkerTask> WorkerTasks { get; set; } 
    }

    [Table("Task", Schema = "Chapter6")]
    public class Task
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TaskId { get; set; }

        [Column("Name")]
        public string Title { get; set; }

        [ForeignKey("TaskId")]
        public virtual ICollection<WorkerTask> WorkerTasks { get; set; } 
    }

    [Table("WorkerTask", Schema = "Chapter6")]
    public class WorkerTask
    {
        [Key]
        [Column(Order = 1)]
        public int WorkerId { get; set; }
        
        [Key]
        [Column(Order = 2)]
        public int TaskId { get; set; }

        [ForeignKey("WorkerId")]
        public virtual Worker Worker { get; set; }

        [ForeignKey("TaskId")]
        public virtual Task Task { get; set; }
    }
}
