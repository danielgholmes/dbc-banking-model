class ATM
{
	invariant()
	{
		writeln("<<ATM.invariant>>");
	    assert(cashBalance == servicedAmount - withdrawsTotal);
	}

	this(in int twohundreds,in int hundreds,in int fifties) // constructor to initialise values
	in
	{
		writeln("<<ATM.constructor.in>>");
	    assert(twohundreds > 0 && hundreds > 0 && fifties > 0);
		writeln("Preconditions: validation of contructor arguments ... OK!");
	}
	body
	{
		writeln("<<ATM.contructor.body>>");
	    withdrawsTotal = 0;
	    twohundredNotes = twohundreds;
	    hundredNotes = hundreds;
	    fiftyNotes= fifties;
	    servicedAmount = twohundredNotes + hundredNotes + fiftyNotes;
	    cashBalance = servicedAmount - withdrawsTotal;
	}

	int[] withdraw(in int amount)
	in
	{
		writeln("<<ATM.withdraw.in>>");
		assert(amount > 0);
		assert(amount % 50 == 0);
	}
	out (result)
	{ // checks that only available notes are issued
		writeln("<<ATM.withdraw.out>>");
		assert(result[0] <= twohundredNotes && result[1] <= hundredNotes && result[2] <= fiftyNotes);
	}
	body
	{
		writeln("<<ATM.withdraw.body>>");
	    return [1, 2, 3];
	}

protected:
	int cashBalance;
	int depositsTotal;
	int withdrawsTotal;
	int servicedAmount;
	
	int twohundredNotes;
	int hundredNotes;
	int fiftyNotes;

	// other member functions ...
}

class AdvancedATM : ATM
{
public:

    this(in int twohundreds, in int hundreds, in int fifties, in int twenties ,in int tens)
	in
	{
		writeln("<<AdvancedATM.constructor.in>>");
		assert(twohundreds > 0 && hundreds > 0 && fifties > 0 && twenties > 0 && tens > 0);
		writeln("Preconditions: validation of contructor arguments ... OK!");
	}
	body
	{
		super(twohundreds, hundreds, fifties);
		writeln("<<AdvancedATM.constructor.body>>");
		withdrawsTotal = 0;
		twohundredNotes = twohundreds;
		hundredNotes = hundreds;
		fiftyNotes= fifties;
		twentyNotes = twenties;
		tenNotes = tens;
		servicedAmount = twohundredNotes + hundredNotes + fiftyNotes + twentyNotes + tenNotes;
		cashBalance = servicedAmount - withdrawsTotal;
		writeln("New advancedATM object successfully created!");
	}

	override int[] withdraw(in int amount)
	in
	{
		writeln("<<AdvancedATM.withdraw.in>>");
		assert(amount > 0);
		assert(amount % 50 == 0 || amount % 10 == 0); // weakens preconditions
	}
	out (result)
	{ 
		writeln("<<AdvancedATM.withdraw.out>>");
		assert(result[0] <= twohundredNotes && result[1] <= hundredNotes
			&& result[2] <= fiftyNotes      && result[3] <= twentyNotes
			&& result[4] <= tenNotes); // strengthens postconditions
	}
	body
	{
		writeln("<<AdvancedATM.withdraw.body>>");
		return [1, 2, 3, 4, 5];
	}

private:
	int twentyNotes;
	int tenNotes;

	// other member functions ...
}

import std.stdio;
import std.c.stdlib; 

int main(string[] argv)
{
	writeln("---------------------------------------------------------");
	writeln("| Demostrating Design by Contract - ATM withdrawal model |");
	writeln("| Created by Daniel G. Holmes, 2015                      |");
	writeln("| PLEASE REFER TO README                                 |");
	writeln("---------------------------------------------------------");
	write("\n");
	system("PAUSE");
	
	writeln("Creating a new advancedATM object...");
	writeln("This models the commishoning of a new ATM.");
	writeln("Constructor arguements are the initial number of individual notes loaded.");

	auto advancedATM = new AdvancedATM(10, 10, 10, 10, 10);
	system("PAUSE");
	
	writeln("\n", "bla!");

	system("PAUSE");
	
    return 0;
}


