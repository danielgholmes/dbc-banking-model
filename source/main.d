class Account
{
protected:
	float balance;
	float depositSum;
	float withdrawSum;
	float chargesSum;

	float withdrawLimit;
	float charge;
	int withdrawNum;

	invariant()
	{
		assert(balance == depositSum + depositSum - withdrawSum - chargesSum);
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
		assert(withdrawNum > 0);
	}
	body
	{
		balance -= amount + charge;
		withdrawSum += amount;
		chargesSum += charge;
		withdrawNum++;
	}
}

class SavingsAccount : Account
{
	override void withdraw(in float amount)
	{
		balance -= amount + charge;
		withdrawSum += amount;
		chargesSum += charge;
		withdrawNum++;		
	}
}

class StudentAccount : Account
{
	override void withdraw(in float amount)
	in
	{
		assert(amount <= balance); // weakening of precondition, no withdraw charges
	}
	out
	{
		assert(withdrawNum < 10); // strengthening of postcondition, limit on withdrawals
	}
	body
	{
		balance -= amount;
		withdrawSum += amount;
		chargesSum += charge;
		withdrawNum++;	
	}
}

import std.stdio;
import std.c.stdlib; 

int main(string[] argv)
{
    writeln("Hello D-World!");
    system("PAUSE");
    return 0;
}
