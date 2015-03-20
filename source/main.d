class Account
{
public:
	this() // constructor to initialise values
	{
		balance = 0.0;
		depositTotal = 0.0;
		withdrawTotal = 0.0;
		chargesTotal = 0.0;
		charge = 2.0; // default amount
		withdrawLimit = 1000.0; // default amount
		freeWithdraw = 10;
		withdrawCount = 0;
	}

	void withdraw(in float amount)
	in
	{
		assert(amount > 0.0);
		assert(amount <= withdrawLimit);
		assert(amount <= balance + charge);
	}
	out
	{
		assert(withdrawCount > 0);
	}
	body
	{
		withdrawCount++;
		if (withdrawCount % freeWithdraw != 0)
		{
			balance -= amount + charge;
			chargesTotal += charge;
		}
		else balance -= amount;

		withdrawTotal += amount;
	}

	// other member functions ...

	invariant()
	{
		assert(balance == depositTotal - withdrawTotal - chargesTotal);
	}

protected:
	float balance;
	float depositTotal;
	float withdrawTotal;
	float chargesTotal;

	float charge;
	float withdrawLimit;
	int withdrawCount;

private:
	float freeWithdraw;

	// other member functions ...
}

class Savings : Account
{
public:
	this(in float initDeposit)
	in
	{
		assert(initDeposit > 100.0);
	}
	out 
	{
		assert(balance == initDeposit);
	}
	body
	{
		depositTotal = initDeposit;
		withdrawLimit = 0.0;
		charge = 10.0;
		withdrawTotal = 0.0;
		chargesTotal = 0.0;
		withdrawCount = 0;
		balance = depositTotal;
	}

	override void withdraw(in float amount)
	in
	{
		assert(amount > 0.0);
		assert(amount <= balance + charge); // weakening of preconditions
	}
	out
	{
		assert(withdrawCount > 0);	
		assert(withdrawTotal > amount);
		assert(chargesTotal % charge == 0); // strengthening of postconditions
	}
	body
	{
		balance -= amount + charge;
		withdrawTotal += amount;
		chargesTotal += charge;
		withdrawCount++;		
	}

	// other member functions ...
}

import std.stdio;
import std.c.stdlib; 

int main(string[] argv)
{
    writeln("Hello D-World!");
    system("PAUSE");
    return 0;
}
