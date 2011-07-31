/*

Processing & Google Spreasheet API Example
blprnt@blprnt.com
July, 2009

*/

SimpleSpreadsheetManager sm;

void setup() {
  size(500,500);
  background(255);
  
  SimpleSpreadsheetManager sm = new SimpleSpreadsheetManager();
	sm.init("test","krystof.pesek@gmail.com", "cigareta");
		sm.fetchSheetByKey("tZJr_DDPd33YdTrCLpnxSpw", 0);

}

void draw() {

	background(0);
}




