﻿using FluentValidation;
using System.Linq;

namespace MShare_ASP.API.Request
{
    /// <summary>Describes the structure of the request for creating a new spending</summary>
    public class NewSpending
    {
        /// <summary>Debtor structure that should be added for this Spending</summary>
        public class Debtor
        {
            /// <summary>Id of the debtor</summary>
            public long DebtorId { get; set; }

            /// <summary>
            /// Debt owed by this debtor
            /// Be aware: the sum of all of the debts, must be equal to MoneySpent!
            /// Note: calculate it client side
            /// </summary>
            public long Debt { get; set; }
        }

        /// <summary>Group id of the spending to be added to</summary>
        public long GroupId { get; set; }

        /// <summary>Name of the spending</summary>
        public string Name { get; set; }

        /// <summary>Amount of money that has been spent</summary>
        public long MoneySpent { get; set; }

        /// <summary>List of debtors, always specify this</summary>
        public Debtor[] Debtors { get; set; }

        /// <summary>Date of the spending</summary>
        public string Date { get; set; }
    }

    /// <summary>Validator object for NewSpending's Debtor subclass</summary>
    public class NewSpending_DebtorValidator : AbstractValidator<NewSpending.Debtor>
    {
        /// <summary>Initializes the validator object</summary>
        public NewSpending_DebtorValidator()
        {
            RuleFor(x => x.DebtorId)
                .NotEmpty();

            RuleFor(x => x.Debt)
                .NotEmpty()
                .GreaterThan(0)
                .WithMessage("Debt should not be 0");
        }
    }

    /// <summary>Validator object for NewUser data class</summary>
    public class NewSpendingValidator : AbstractValidator<NewSpending>
    {
        /// <summary>Initializes the validator object</summary>
        public NewSpendingValidator()
        {
            RuleFor(x => x.MoneySpent)
                .NotEmpty()
                .GreaterThan(0);

            RuleFor(x => x.Name)
                .NotEmpty()
                .MaximumLength(32);

            RuleFor(x => x.GroupId)
                .NotEmpty();

            RuleForEach(x => x.Debtors)
                .SetValidator(new NewSpending_DebtorValidator());

            RuleFor(x => x.Debtors)
                .NotEmpty()
                .Must((args, d) => d.Sum(m => m.Debt) == args.MoneySpent)
                    .WithMessage("Fully specified debts sum is not equal to MoneySpent");

            RuleFor(x => x.Date)
                .NotNull()
                .Matches("\\b[0-9]{4}-[0-9]{2}-[0-9]{2}\\b");
        }
    }
}