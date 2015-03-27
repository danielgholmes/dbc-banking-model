Demostrating Design by Contract - ATM withdrawal model

Author: Daniel G. Holmes
-----------------------------------------------------

The purpose of the program is to model the withdrawal feature of two different types of ATM's in order demonstrate principles of Design by Contract. The one ATM is a standard ATM which has a limited set of bank notes available for withdrawal. This can also be though of as an ATM that has limited features. The other ATM can be thought of as an an advanved ATM, offering better services. Unlike the standard one, the advanced ATM offers all types of bank notes available in South Africa (200s, 100s, 50s, 20s, 10s).

The program consists of a parent class "ATM" and a derived class "AdvancedATM". The principles of Design by Contract are demonstrated within the context of these two classes. 

Messages in the window encapsulated as "<< ... >>" are used to indicates when a specific point in the program has been reached. This aids in the demontration of the logical flow of a program that uses Design by Contract, especially where inheritance is involved.

Example: "<<class.operation.suboperation>>"

The suboperation specifies whether preconditions, postconditions or the function body has been run (each denoted by "in", "out" and "body" respectively).