using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe6
{
    class Program
    {
        static void Main(string[] args)
        {
            RunExample();
        }

        static void DeleteRelatedEntities<T>(T entity, EFRecipesEntities context)
                    where T : EntityObject
        {
            var entities = ((IEntityWithRelationships)entity)
                            .RelationshipManager.GetAllRelatedEnds()
                            .SelectMany(e =>
                              e.CreateSourceQuery().OfType<EntityObject>()).ToList();
            foreach (var child in entities)
            {
                context.DeleteObject(child);
            }
            context.SaveChanges();
        }

        static void RunExample()
        {
            using (var context = new EFRecipesEntities())
            {
                var recipe1 = new Recipe { RecipeName = "Chicken Risotto" };
                var recipe2 = new Recipe { RecipeName = "Baked Chicken" };
                recipe1.Steps.Add(new Step { Description = "Bring Broth to a boil" });
                recipe1.Steps.Add(new Step
                {
                    Description =
                      "Slowly add Broth to Rice"
                });
                recipe1.Ingredients.Add(new Ingredient { Name = "1 Cup White Rice" });
                recipe1.Ingredients.Add(new Ingredient
                {
                    Name =
                        "6 Cups Chicken Broth"
                });
                recipe2.Steps.Add(new Step
                {
                    Description =
                      "Bake at 350 for 35 Minutes"
                });
                recipe2.Ingredients.Add(new Ingredient { Name = "1 lb Chicken" });
                context.Recipes.AddObject(recipe1);
                context.Recipes.AddObject(recipe2);
                context.SaveChanges();
                Console.WriteLine("All the Related Entities...");
                ShowRecipes();
                DeleteRelatedEntities(recipe2, context);
                Console.WriteLine("\nAfter Related Entities are Deleted...");
                ShowRecipes();
            }
        }

        static void ShowRecipes()
        {
            using (var context = new EFRecipesEntities())
            {
                foreach (var recipe in context.Recipes)
                {
                    Console.WriteLine("\n*** {0} ***", recipe.RecipeName);
                    Console.WriteLine("Ingredients");
                    foreach (var ingredient in recipe.Ingredients)
                    {
                        Console.WriteLine("\t{0}", ingredient.Name);
                    }
                    Console.WriteLine("Steps");
                    foreach (var step in recipe.Steps)
                    {
                        Console.WriteLine("\t{0}", step.Description);
                    }
                }
            }
        }
    }
}
