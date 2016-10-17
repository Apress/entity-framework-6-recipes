using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.ModelingFundamentals.Recipe7
{
    public static class Recipe7Program
    {
        public static void Run()
        {
            byte[] thumbBits = new byte[100];
            byte[] fullBits = new byte[2000];
            using (var context = new Recipe7Context())
            {
                var photo = new Photograph { Title = "My Dog", 
                                             ThumbnailBits = thumbBits };
                var fullImage = new PhotographFullImage { HighResolutionBits = fullBits };
                photo.PhotographFullImage = fullImage;
                context.Photographs.Add(photo);
                context.SaveChanges();
            }

            using (var context = new Recipe7Context())
            {
                foreach (var photo in context.Photographs)
                {
                    Console.WriteLine("Photo: {0}, ThumbnailSize {1} bytes", 
                                       photo.Title, photo.ThumbnailBits.Length);

                    // explicitly load the "expensive" entity, PhotographFullImage
                    context.Entry(photo).Reference(p => p.PhotographFullImage).Load();        
                    Console.WriteLine("Full Image Size: {0} bytes",
                            photo.PhotographFullImage.HighResolutionBits.Length);
                }
            }
            
        }
    }
}
