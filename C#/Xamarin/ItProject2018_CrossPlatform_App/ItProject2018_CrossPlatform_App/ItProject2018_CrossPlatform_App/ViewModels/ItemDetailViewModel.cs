using System;

using ItProject2018_CrossPlatform_App.Models;

namespace ItProject2018_CrossPlatform_App.ViewModels
{
    public class ItemDetailViewModel : BaseViewModel
    {
        public Item Item { get; set; }
        public ItemDetailViewModel(Item item = null)
        {
            Title = item?.Text;
            Item = item;
        }
    }
}
