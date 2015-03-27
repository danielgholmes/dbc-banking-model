Demonstrating Design by Contract - ATM withdrawal model

Author: Daniel G. Holmes
-----------------------------------------------------

The purpose of this program is to model the withdrawal feature of two different types of ATM's in order to demonstrate principles of Design by Contract. The first ATM is a standard ATM which has a limited set of bank notes available for withdrawal (200's, 100's, 50's). This can also be thought of as an ATM that has limited features. The other ATM can be thought of as an an advanved ATM, offering better services. Unlike the standard one, the advanced ATM offers all types of bank notes available in South Africa (200's, 100's, 50's, 20's, 10's).

The program consists of a parent class "ATM" and a derived class "AdvancedATM". The principles of Design by Contract are demonstrated within the context of these two classes. 

Messages in the window are encapsulated as "<< ... >>" and are used to indicate when a specific point in the program has been reached. This aids in the demonstration of the logical flow of a program that uses Design by Contract, especially where inheritance is involved.

Example: "<<class.operation.suboperation>>"

The suboperation specifies whether preconditions, postconditions or the function body has been run (each denoted by "in", "out" and "body" respectively).

Any input to the program that 