using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookRepository
{
	public class BookRepository
	{
		private TestEntities _context;

		public BookRepository(TestEntities context)
		{
			_context = context;
		}

		public void InsertBook(Book book)
		{
			_context.Books.Add(book);
		}

		public void InsertCategory(Category category)
		{
			_context.Categories.Add(category);
		}

		public void SaveChanges()
		{
			_context.SaveChanges();
		}

		public IQueryable<Book> BooksByCategory(string name)
		{
			return _context.Books.Where(b => b.Category.Name == name);
		}

		public IQueryable<Book> BooksByYear(int year)
		{
			return _context.Books.Where(b => b.PublishDate.Year == year);
		}
	}
}