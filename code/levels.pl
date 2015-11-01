level(1, purple).
level(2, blue).
level(3, green).
level(4, yellow).
level(5, orange).
level(6, red).

calculateLevel(X,Y, Level):-
	DeltaX is 7-X,
	DeltaY is 7-Y,
	Level is max(DeltaX, DeltaY),
	level(Level, Color).
