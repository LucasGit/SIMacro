/* Utils.em - a small collection of useful editing macros */



/* InsertFileHeader:

   Inserts a comment header block at the top of the current function. 
   This actually works on any type of symbol, not just functions.

   To use this, define an environment variable "MYNAME" and set it
   to your email name.  eg. set MYNAME=raygr
*/
/*-------------------------------------------------------------------------
	I N S E R T   H E A D E R

	Inserts a comment header block at the top of the current function. 
	This actually works on any type of symbol, not just functions.

	To use this, define an environment variable "MYNAME" and set it
	to your email name.  eg. set MYNAME=raygr
-------------------------------------------------------------------------*/

/*
note:source insight 的宏扩展描述其实不需要分号的，这里增加分号是编程习惯
*/
macro getFunType()
{
	//var fType;
	//fType=ASK("请输入函数返回类型");
	//return fType;
	return "Funtion Type";
}
macro getFunName()
{
	//var fName;
	//fName=ASK("请输入函数名字");
	//return fName;
	return "Funtion Name";
}
macro getFunDesc()
{
    //var fDesc;
    //fDesc=ASK("请输入函数描述");
    //return fDesc;
	return "Funtion Desc";
}
macro getFunParamNum()
{
	var fParamNum;
	fParamNum=ASK("请输入参数个数")；
	return fParamNum;
}
macro getFunParamType()
{
	//var fParamType;
	//fParamType=ASK("请输入参数类型");
	//return fParamType;
	return "Param Type";
}
macro getFunInputParamArray()
{
	var fParam;
	fParam=ASK("请输入输入参数列表多个以逗号隔开");
	return fParam;
}
macro getFunOutputParamArray()
{
	var fParam;
	fParam=ASK("请输入输出参数列表多个以逗号隔开");
	return fParam;
}
macro getAuthor()
{
	//var fAuthor;
	//fAuthor=ASK("请输入作者姓名工号")；
	//return fAuthor;
	return "Lucas";
}

macro getCommentsTime()
{
    var  year;
    var  month;
    var  day;
    var  commTime;
    var  sysTime;

    sysTime  = GetSysTime(1);
    year 	 = sysTime.Year;
    month 	 = sysTime.month;
    day 	 = sysTime.day;
	hour 	 = sysTime.Hour;
	min 	 = sysTime.Minute;
	sec 	 = sysTime.Second;
	
	if (month < 10)
		szMonth = "0@month@"
	else
		szMonth = month
	
	if (day < 10)
		szDay = "0@day@"
	else
		szDay = day
	
	if (hour < 10)
		szHour = "0@hour@"
	else
		szHour = hour

	if (min < 10)
		szMin = "0@min@"
	else
		szMin = min

	if (sec < 10)
		szSec = "0@sec@"
	else
		szSec = sec


    commTime = "@year@/@szMonth@/@szDay@ @szHour@:@szMin@:@szSec@";
    return commTime;
}

macro InsertHeader()
{
	var hBuff;
    var line;

 	var ftype;
 	var fname;
 	var fdesc;
 	var fiparam;
 	var foparam;
 	var fauthor;
    var time;
    var comments;
    
    time=getCommentsTime();
	fauthor=getAuthor();
	ftype=getFunType();
	fname=getFunName();
	fdesc=getFunDesc();

	fiparam=getFunInputParamArray();
	foparam=getFunOutputParamArray();

 	hBuff = GetCurrentBuf();
    line = GetBufLnCur (hBuff);

	InsBufLine(hBuff, line, "/*************************************************************");

	comments = "函      数      名:";
    comments = cat(comments,fname);
	InsBufLine(hBuff,line+1,comments);

	comments = "函  数  描  述:";
    comments = cat(comments,fdesc);
	InsBufLine(hBuff,line+2,comments);	

	comments = "输  入  参  数:";
    comments = cat(comments,fiparam);
	InsBufLine(hBuff,line+3,comments);	

	comments = "输  出  参  数:";
    comments = cat(comments,foparam);
	InsBufLine(hBuff,line+4,comments);	

	comments = "返  回  类  型:";
    comments = cat(comments,ftype);
	InsBufLine(hBuff,line+5,comments);	

	comments = "备          注:";
	InsBufLine(hBuff,line+6,comments);		

 	comments = "  作          者:";
 	comments = cat(comments,fauthor);
	InsBufLine(hBuff,line+7,comments);

 	comments = "  时          间:";
 	comments = cat(comments,time);
	InsBufLine(hBuff,line+8,comments);	

	InsBufLine(hBuff, line+9, "*************************************************************/");

    //下来是生成函数体部分
    //函数定义部分
	comments = "";
	comments = cat(comments,ftype);
	comments = cat(comments," ");
	comments = cat(comments,fname);
	comments = cat(comments,"(");
	comments = cat(comments,fiparam);
	comments = cat(comments,", ");
	comments = cat(comments,foparam);
	comments = cat(comments,")");
	InsBufLine(hBuff,line+10,comments);

	InsBufLine(hBuff,line+11,"{");

	InsBufLine(hBuff,line+12,"	");

	comments = "	";
	comments = cat(comments,"XX_LOG(INFORMATIONAL, \"Enter ");
	comments = cat(comments,fname);
	comments = cat(comments,"!\");");
	InsBufLine(hBuff,line+13,comments);

	InsBufLine(hBuff,line+14,"	//入参判断");

	InsBufLine(hBuff,line+15,"	if( COND == PARAM )");
	InsBufLine(hBuff,line+16,"	{");
	InsBufLine(hBuff,line+17,"		XX_LOG(WARNNING, \"the input pram is invalid!\");");
	InsBufLine(hBuff,line+18,"		return  ;");
	InsBufLine(hBuff,line+19,"	}");

	InsBufLine(hBuff,line+20,"	");

	comments = "	";
	comments = cat(comments,"XX_LOG(INFORMATIONAL, \"Exit ");
	comments = cat(comments,fname);
	comments = cat(comments,"!\");");
	InsBufLine(hBuff,line+21,comments);
	
	InsBufLine(hBuff,line+22,"	return  ;");
	InsBufLine(hBuff,line+23,"}");
}


macro InsertFuntionHeader()
{
	time	 = getCommentsTime();
	author   = getAuthor();
	hbuf 	 = GetCurrentBuf()
	line     = GetBufLnCur(hbuf);

	InsBufLine(hbuf, line++,   "/**********************************************************************//**");
	InsBufLine(hbuf, line++,  "@@brief	");
	InsBufLine(hbuf, line++,  "");
	InsBufLine(hbuf, line++,  "@@Param 	[In]	");
	InsBufLine(hbuf, line++,  "@@Param 	[Out]	");
	InsBufLine(hbuf, line++,  "");
	InsBufLine(hbuf, line++,  "@@retval  ");
	InsBufLine(hbuf, line++,  "");
	InsBufLine(hbuf, line++,  "@@author @author@");
	InsBufLine(hbuf, line++,  "@@date	@time@");
	InsBufLine(hbuf, line++,  "");
	InsBufLine(hbuf, line++,  "@@note	");
	InsBufLine(hbuf, line++, "History");
	InsBufLine(hbuf, line++, "**************************************************************************/");
}

macro GetCurPureFileName()
{
     hbuf = GetCurrentBuf()
     
     fullname = GetBufName(hbuf)  
     length = strlen(fullname) 
     if (length == 0)
         return ""
      index = length
      while ("\\" !=  fullname[--index]);
  
      purename = ""
      while (index < length)
          purename = cat(purename, fullname[++index])
          
      return purename
 }

macro InsertFileHeader()
{
	time	 = getCommentsTime();
	author   = getAuthor();
	hbuf 	 = GetCurrentBuf()
	line     = GetBufLnCur(hbuf);
	filename = GetCurPureFileName()

	InsBufLine(hbuf, line++,   "/**********************************************************************//**");
	InsBufLine(hbuf, line++,  "		 	 Meteor Firmware Platform");
	InsBufLine(hbuf, line++,  "			XX  Module");
	InsBufLine(hbuf, line++,  "*-");
	InsBufLine(hbuf, line++,  "@@file 	@filename@");
	InsBufLine(hbuf, line++,  "@@author @author@");
	InsBufLine(hbuf, line++,  "@@date	@time@");
	InsBufLine(hbuf, line++,  "@@brief	");
	InsBufLine(hbuf, line++, "**************************************************************************/");
}

macro InsertTimestamp()
{
	time	 = getCommentsTime();
	hbuf 	 = GetCurrentBuf()
	line     = GetBufLnCur(hbuf);
	InsBufLine(hbuf, line  "@time@");
}


macro InsertComment1()
{
	hbuf = GetCurrentBuf()
	line = GetBufLnCur(hbuf);
	text = GetBufLine(hbuf, line);
	ipos = strlen(text)
	
	SetBufIns(hbuf, line,ipos);
	InsBufLine(hbuf, line,"@text@/**  */");
	SetBufIns(hbuf, line, ipos + 4);
}

macro InsertComment2()
{
	hbuf = GetCurrentBuf()
	line = GetBufLnCur(hbuf);
	InsBufLine(hbuf, line, "/**<  */");
	SetBufIns(hbuf, line, 5);
}

macro InsertCommentTODO()
{
	time	 = getCommentsTime();
	author   = getAuthor();
	hbuf 	 = GetCurrentBuf()
	line     = GetBufLnCur(hbuf);

	InsBufLine(hbuf, line,  "/** TODO:  [@time@:@author@] */");
	SetBufIns(hbuf, line, 10);
}

// Inserts "Returns True .. or False..." at the current line
macro ReturnTrueOrFalse()
{
	hbuf = GetCurrentBuf()
	ln = GetBufLineCur(hbuf)

	InsBufLine(hbuf, ln, "    Returns True if successful or False if errors.")
}



/* Inserts ifdef REVIEW around the selection */
macro IfdefReview()
{
	IfdefSz("REVIEW");
}


/* Inserts ifdef BOGUS around the selection */
macro IfdefBogus()
{
	IfdefSz("BOGUS");
}


/* Inserts ifdef NEVER around the selection */
macro IfdefNever()
{
	IfdefSz("NEVER");
}


// Ask user for ifdef condition and wrap it around current
// selection.
macro InsertIfdef()
{
	sz = Ask("Enter ifdef condition:")
	if (sz != "")
		IfdefSz(sz);
}

// Ask user for ifdef condition and wrap it around current
// selection.
macro InsertIfndef()
{
	sz = Ask("Enter ifndef condition:")
	if (sz != "")
		IfndefSz(sz);
}

macro InsertCPlusPlus()
{
	IfdefSz("__cplusplus");
}


// Wrap ifdef <sz> .. endif around the current selection
macro IfdefSz(sz)
{
	hbuf = GetCurrentBuf()
	line = GetBufLnCur(hbuf);
	 
	InsBufLine(hbuf, line++, "#ifdef @sz@")
	InsBufLine(hbuf, line++, "#endif /* @sz@ */")
}


// Wrap ifdef <sz> .. endif around the current selection
macro IfndefSz(sz)
{
	hbuf = GetCurrentBuf()
	line = GetBufLnCur(hbuf);
	 
	InsBufLine(hbuf, line++, "#ifndef @sz@")
	InsBufLine(hbuf, line++, "#define @sz@")
	InsBufLine(hbuf, line++, "")
	InsBufLine(hbuf, line++, "")
	InsBufLine(hbuf, line++, "")
	InsBufLine(hbuf, line++, "#endif /* @sz@ */")
}


// Delete the current line and appends it to the clipboard buffer
macro KillLine()
{
	hbufCur = GetCurrentBuf();
	lnCur = GetBufLnCur(hbufCur)
	hbufClip = GetBufHandle("Clipboard")
	AppendBufLine(hbufClip, GetBufLine(hbufCur, lnCur))
	DelBufLine(hbufCur, lnCur)
}


// Paste lines killed with KillLine (clipboard is emptied)
macro PasteKillLine()
{
	Paste
	EmptyBuf(GetBufHandle("Clipboard"))
}



// delete all lines in the buffer
macro EmptyBuf(hbuf)
{
	lnMax = GetBufLineCount(hbuf)
	while (lnMax > 0)
		{
		DelBufLine(hbuf, 0)
		lnMax = lnMax - 1
		}
}


// Ask the user for a symbol name, then jump to its declaration
macro JumpAnywhere()
{
	symbol = Ask("What declaration would you like to see?")
	JumpToSymbolDef(symbol)
}

	
// list all siblings of a user specified symbol
// A sibling is any other symbol declared in the same file.
macro OutputSiblingSymbols()
{
	symbol = Ask("What symbol would you like to list siblings for?")
	hbuf = ListAllSiblings(symbol)
	SetCurrentBuf(hbuf)
}


// Given a symbol name, open the file its declared in and 
// create a new output buffer listing all of the symbols declared
// in that file.  Returns the new buffer handle.
macro ListAllSiblings(symbol)
{
	loc = GetSymbolLocation(symbol)
	if (loc == "")
		{
		msg ("@symbol@ not found.")
		stop
		}
	
	hbufOutput = NewBuf("Results")
	
	hbuf = OpenBuf(loc.file)
	if (hbuf == 0)
		{
		msg ("Can't open file.")
		stop
		}
		
	isymMax = GetBufSymCount(hbuf)
	isym = 0;
	while (isym < isymMax)
		{
		AppendBufLine(hbufOutput, GetBufSymName(hbuf, isym))
		isym = isym + 1
		}

	CloseBuf(hbuf)
	
	return hbufOutput

}
