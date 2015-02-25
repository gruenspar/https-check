#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>


/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int match(char * string, char * pattern) {
	int result;
	regex_t reg;
	
	if (regcomp(&reg, pattern, REG_EXTENDED | REG_NOSUB) != 0) return -1;s
	result = regexec(&reg, string, 0, 0, 0);
	regfree(&reg);
	return result;
}

int main(void) {
	FILE *datei;
	char text[500];
	datei = fopen("C:\\test\\Quelltext.html", "r");
	//datei = fopen("https://www.gruenspar.at", "r");
	
	if (datei == NULL) {
		printf("Fehler beim Oeffnen! Bitte ueberpruefe deinen Pfad!\n");
		getch();
	}
	if (fgets(text, 500, datei) != NULL) {
		while(fgets(text, 500, datei)) {
			puts(text);
		}
	}
	getch();
	fclose(datei);
	return 0;
}
