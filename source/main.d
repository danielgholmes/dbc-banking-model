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
		assert(balance == depositSum - withdrawSum - chargesSum);
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

class Savings : Account
{
	this(float initDeposit)
	{
		depositSum = initDeposit;
		withdrawLimit = 1000.0;
		charge = 5.0;
		withdrawSum = 0.0;
		chargesSum = 0.0;
		withdrawNum = 0;
		balance = depositSum;
	}

	override void withdraw(in float amount)
	{

	}
}

class Cheque : Account
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
