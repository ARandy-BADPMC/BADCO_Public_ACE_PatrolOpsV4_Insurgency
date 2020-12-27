/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createDiaryNote.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a note in the mission diary
*/
params [["_subjectID","",[""]],["_subjectTitle","",[""]],["_recordTitle","",[""]],["_recordText","",[""]]];

if (_subjectTitle isEqualTo "") then { _subjectTitle = _subjectID; };

if !(player diarySubjectExists _subjectID) then {
	player createDiarySubject [_subjectID,_subjectTitle];
};

if (_recordTitle isEqualTo "" && !(_subjectTitle isEqualTo "")) then {
	_recordTitle = _subjectTitle;
};

if (_recordTitle isEqualTo "") then {
	player createDiaryRecord [_subjectID,_recordText];
} else {
	player createDiaryRecord [_subjectID,[_recordTitle,_recordText]];
};