﻿using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyMenu.Api.Models.Infrastructure
{
    public interface IDishRepository
    {
        Task<DishModel> CreateAsync(DishModel dish);

        Task<DishModel> EditAsync(int id, DishModel dish);

        Task<DishModel> FindAsync(int id);

        Task<IEnumerable<DishModel>> GetAllAsync(int restaurantId);

        Task<IEnumerable<DishModel>> SearchAsync(string search);
    }
}
