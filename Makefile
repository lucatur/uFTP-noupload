#Linux Generic
OUTPATH=./build/
SOURCE_MODULES_PATH=./library/

CFLAGSTEMP=-c -Wall -I.

CFLAGS:=-O3
LIBPATH=./build/modules/
LIBS=-lpthread

ENABLE_LARGE_FILE_SUPPORT:=-D LARGE_FILE_SUPPORT_ENABLED -D _LARGEFILE64_SOURCE

ENABLE_OPENSSL_SUPPORT=
#TO ENABLE OPENSSL SUPPORT UNCOMMENT NEXT 2 LINES
#ENABLE_OPENSSL_SUPPORT=-D OPENSSL_ENABLED
#LIBS=-lpthread -lssl -lcrypto

ENABLE_PAM_SUPPORT=
PAM_AUTH_LIB=
#TO ENABLE PAM AUTH UNCOMMENT NEXT TWO LINES
#ENABLE_PAM_SUPPORT= -D PAM_SUPPORT_ENABLED
#PAM_AUTH_LIB= -lpam

CFLAGS+=$(CFLAGSTEMP) $(ENABLE_LARGE_FILE_SUPPORT) $(ENABLE_OPENSSL_SUPPORT) $(ENABLE_PAM_SUPPORT)

all: $(OUTPATH)uFTP

$(OUTPATH)uFTP: uFTP.c $(LIBPATH)dynamicVectors.o $(LIBPATH)fileManagement.o $(LIBPATH)configRead.o $(LIBPATH)logFunctions.o $(LIBPATH)ftpCommandElaborate.o $(LIBPATH)ftpData.o $(LIBPATH)ftpServer.o $(LIBPATH)daemon.o $(LIBPATH)signals.o $(LIBPATH)connection.o $(LIBPATH)openSsl.o $(LIBPATH)dynamicMemory.o $(LIBPATH)errorHandling.o $(LIBPATH)auth.o
	@$(CC)  $(ENABLE_LARGE_FILE_SUPPORT) $(ENABLE_OPENSSL_SUPPORT) uFTP.c $(LIBPATH)dynamicVectors.o $(LIBPATH)fileManagement.o $(LIBPATH)configRead.o $(LIBPATH)logFunctions.o $(LIBPATH)ftpCommandElaborate.o $(LIBPATH)ftpData.o $(LIBPATH)ftpServer.o $(LIBPATH)daemon.o $(LIBPATH)signals.o $(LIBPATH)connection.o $(LIBPATH)openSsl.o $(LIBPATH)dynamicMemory.o $(LIBPATH)errorHandling.o $(LIBPATH)auth.o -o $(OUTPATH)uFTP $(LIBS) $(PAM_AUTH_LIB)
	
$(LIBPATH)daemon.o: library/daemon.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)daemon.c -o $(LIBPATH)daemon.o

$(LIBPATH)dynamicVectors.o: library/dynamicVectors.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)dynamicVectors.c -o $(LIBPATH)dynamicVectors.o

$(LIBPATH)openSsl.o: library/openSsl.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)openSsl.c -o $(LIBPATH)openSsl.o

$(LIBPATH)auth.o: library/auth.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)auth.c -o $(LIBPATH)auth.o

$(LIBPATH)configRead.o: library/configRead.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)configRead.c -o $(LIBPATH)configRead.o

$(LIBPATH)dynamicMemory.o: library/dynamicMemory.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)dynamicMemory.c -o $(LIBPATH)dynamicMemory.o

$(LIBPATH)errorHandling.o: library/errorHandling.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)errorHandling.c -o $(LIBPATH)errorHandling.o

$(LIBPATH)fileManagement.o: library/fileManagement.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)fileManagement.c -o $(LIBPATH)fileManagement.o

$(LIBPATH)signals.o: library/signals.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)signals.c -o $(LIBPATH)signals.o

$(LIBPATH)connection.o: library/connection.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)connection.c -o $(LIBPATH)connection.o

$(LIBPATH)logFunctions.o: library/logFunctions.c
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)logFunctions.c -o $(LIBPATH)logFunctions.o

$(LIBPATH)ftpCommandElaborate.o: ftpCommandElaborate.c
	@$(CC) $(CFLAGS) ftpCommandElaborate.c -o $(LIBPATH)ftpCommandElaborate.o

$(LIBPATH)ftpData.o: ftpData.c
	@$(CC) $(CFLAGS) ftpData.c -o $(LIBPATH)ftpData.o

$(LIBPATH)ftpServer.o: ftpServer.c
	@$(CC) $(CFLAGS) ftpServer.c -o $(LIBPATH)ftpServer.o

.PHONY: clean

clean:
	@rm -rf $(LIBPATH)*.o $(OUTPATH)uFTP
