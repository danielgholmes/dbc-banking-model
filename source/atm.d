class ATM
{
	invariant()
	{// should be maintained for this class and all those derived from it
		writeln("<<ATM.invariant.check>>"); 
	    assert(cashBalance == servicedAmount - withdrawsTotal);
	}

	this(in int twohundreds,in int hundreds,in int fifties) // constructor to initialise values
	in
	{
		writeln("<<ATM.constructor.in>>");
	    assert(twohundreds > 0 && hundreds > 0 && fifties > 0);
		writeln("Preconditions: validation of constructor arguments ... OK!");
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
		withdrawLimit = 5000;
	}

	int[] withdraw(in int amount)
	in
	{
		writeln("<<ATM.withdraw.in>>");
		assert(amount > 0 && amount <= withdrawLimit);
		assert(amount % 50 == 0); // preconditions that need to be met by any derived class
		writeln("Preconditions: validation of withdraw function arguments ... OK!");
	}
	out (result)
	{ // checks that only available notes are issued
		writeln("<<ATM.withdraw.out>>");
		assert(result[0] <= twohundredNotes && result[1] <= hundredNotes && result[2] <= fiftyNotes);
		writeln("Postconditions: base class validation of function execution ... OK!");
	}
	body
	{
		writeln("<<ATM.withdraw.body>>");
		int[] notesToIssue = [0,0,0];
		int amountTracker = amount;

		while(amountTracker != 0) // allocates notes to be issued
		{
			if (amountTracker >= 200)
			{
				amountTracker -= 200;
				notesToIssue[0]++;
				twohundredNotes--;
			}	
			else if (amountTracker >= 100)
			{
				amountTracker -= 100;
				notesToIssue[1]++;
				hundredNotes--;
			}
			else if (amountTracker >= 50)
			{
				amountTracker -= 50;
				notesToIssue[2]++;
				fiftyNotes--;
			}
			else break;
		}
	    return notesToIssue;
	}

protected:
	int cashBalance;
	int depositsTotal;
	int withdrawsTotal;
	int servicedAmount;
	
	int twohundredNotes;
	int hundredNotes;
	int fiftyNotes;

	int withdrawLimit;

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
		writeln("Preconditions: validation of constructor arguments ... OK!");
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
		withdrawLimit = 5000;
		displayAvailableNotes();
	}

	override int[] withdraw(in int amount)
	in
	{
		writeln("Preconditions: validation of base class withdraw function arguments ... FAIL!");
		writeln("<<AdvancedATM.withdraw.in>>");

		assert(amount > 0 && amount <= withdrawLimit);
		assert(amount % 50 == 0 || amount % 10 == 0); // weakens preconditions

		writeln("Preconditions: validation of derived class withdraw function arguments ... OK!");
	}
	out (result)
	{ 
		writeln("<<AdvancedATM.withdraw.out>>");

		assert(result[0] <= twohundredNotes && result[1] <= hundredNotes
			&& result[2] <= fiftyNotes      && result[3] <= twentyNotes
			&& result[4] <= tenNotes); // strengthens postconditions

		writeln("Postconditions: derived class validation of function execution ... OK!");
		writeln("Contracts have been kept. Class invariant maintained.");
		writeln("You have been issues the following notes");
		writeln("200's: ", result[0]);
		writeln("100's: ", result[1]);
		writeln("50's : ", result[2]);
		writeln("20's : ", result[3]);
		writeln("10's : ", result[4]);
		writeln("CASH WITHDRAWAL SUCCESS!");
	}
	body
	{
		writeln("<<AdvancedATM.withdraw.body>>");
		int[] notesToIssue = [0,0,0,0,0];
		int amountTracker = amount;

		while(amountTracker != 0) // allocates notes to be issued
		{
			if (amountTracker >= 200)
			{
				amountTracker -= 200;
				notesToIssue[0]++;
				twohundredNotes--;
			}	
			else if (amountTracker >= 100)
			{
				amountTracker -= 100;
				notesToIssue[1]++;
				hundredNotes--;
			}
			else if (amountTracker >= 50)
			{
				amountTracker -= 50;
				notesToIssue[2]++;
				fiftyNotes--;
			}
			else if (amountTracker >= 20)
			{
				amountTracker -= 20;
				notesToIssue[3]++;
				twentyNotes--;
			}
			else if (amountTracker >= 10)
			{
				amountTracker -= 10;
				notesToIssue[4]++;
				tenNotes--;
			}
			else break;
		}
	    return notesToIssue;
	}

private:
	int twentyNotes;
	int tenNotes;

	void displayAvailableNotes()
	{
		writeln("New advancedATM object successfully created!");
		writeln("Available notes");
		writeln("200's: ", twohundredNotes);
		writeln("100's: ", hundredNotes);
		writeln("50's : ", fiftyNotes);
		writeln("20's : ", twentyNotes);
		writeln("10's : ", tenNotes);
	}

	// other member functions ...
}

import std.stdio;
import std.c.stdlib; 
import std.exception;

int main(string[] argv)
{
	writeln("---------------------------------------------------------");
	writeln("| Demostrating Design by Contract - ATM withdrawal model |");
	writeln("| Created by Daniel G. Holmes, 2015                      |");
	writeln("| PLEASE REFER TO THE README                             |");
	writeln("---------------------------------------------------------");
	write("\n");
	system("PAUSE");
	
	writeln("Creating a new advancedATM object...");
	writeln("This models the commissioning of a new ATM.");
	writeln("Constructor arguments are the initial number of individual notes loaded.");

	auto advancedATM = new AdvancedATM(100, 200, 300, 400, 500);
	system("PAUSE");
	writeln("");

	int withdrawAmount = 0;
	do
	{
		writeln("Please enter a withdrawal amount as an integer multiple of 50 (max 5000).");
		readf(" %s", &withdrawAmount);
	}
	while (withdrawAmount != 0 && withdrawAmount % 50 != 0);
	// NOTE: These verifications are here to facilitate correct running of the demonstration and
	//		 are not intended to supersede the Design by Contract precondition assertions.
	advancedATM.withdraw(withdrawAmount);
	withdrawAmount = 0;
	system("PAUSE");
	writeln("");

	do
	{
		writeln("Now enter a withdrawal amount as a multiple of 10, but not 50 (max 5000).");
		readf(" %s", &withdrawAmount);
	}
	while (withdrawAmount != 0 && withdrawAmount % 10 != 0 && withdrawAmount % 50 != 0);
	// NOTE: These verifications are here to facilitate correct running of the demonstration and
	//		 are not intended to supersede the Design by Contract precondition assertions.
	advancedATM.withdraw(withdrawAmount);
	withdrawAmount = 0;
	system("PAUSE");
	writeln("");
	
	writeln("Demonstration complete!");
	writeln("Enter an invalid amount to see a failed preconditions exception in derived class.");
	readf(" %s", &withdrawAmount);
	advancedATM.withdraw(withdrawAmount);
	system("PAUSE");
	
    return 0;
}


