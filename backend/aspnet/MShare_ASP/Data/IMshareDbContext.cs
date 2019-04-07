﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MShare_ASP.Data {
    /// <summary>
    /// Db Context for all data in MShare
    /// </summary>
    public interface IMshareDbContext  {
        /// <summary>
        /// User informations
        /// </summary>
        DbSet<DaoUser> Users { get; set; }
        /// <summary>
        /// Group specific informations
        /// </summary>
        DbSet<DaoGroup> Groups { get; set; }
        /// <summary>
        /// Tokens that have been sent to users
        /// </summary>
        DbSet<DaoEmailToken> EmailTokens { get; set; }
        /// <summary>
        /// Junction table for many-to-many user-group connections
        /// </summary>
        DbSet<DaoUsersGroupsMap> UsersGroupsMap { get; set; }
    }
}