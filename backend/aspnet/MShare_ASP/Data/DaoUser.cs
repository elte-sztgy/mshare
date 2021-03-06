﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MShare_ASP.Data
{
    /// <summary>Data Access Object for User</summary>
    [Table("users", Schema = "mshare")]
    public class DaoUser
    {
        /// <summary>Primary key of the user</summary>
        [Key]
        [Column("id")]
        public long Id { get; set; }

        /// <summary>Email of the user</summary>
        [Column("email")]
        public string Email { get; set; }

        /// <summary>Hashed password of the user</summary>
        [Column("password")]
        public string Password { get; set; }

        /// <summary>Displayname (not unique!)</summary>
        [Column("display_name")]
        public string DisplayName { get; set; }

        /// <summary>Date and time when the user was registered</summary>
        [Column("creation_date")]
        public DateTime CreationDate { get; set; }

        /// <summary>Currently set language of the user</summary>
        [EnumDataType(typeof(DaoLangTypes.Type))]
        [Column("lang")]
        public DaoLangTypes.Type Lang { get; set; }

        /// <summary>All email tokens associated with user</summary>
        public IEnumerable<DaoEmailToken> EmailTokens { get; set; }

        /// <summary>Bank account number of the user</summary>
        [Column("bank_account_number")]
        public string BankAccountNumber { get; set; }

        /// <summary>All groups associated with user</summary>
        public IEnumerable<DaoUsersGroupsMap> Groups { get; set; }
    }
}