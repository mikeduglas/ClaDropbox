  INCLUDE('ClaDropboxDS.inc'), ONCE
  
  MAP
    MODULE('dbxDS')
      dbxds::DebugInfo(STRING s)
    END
  END

CdbxDSManager                 CLASS(IdbxDatastoreManagerClass), TYPE, MODULE('dbxDS.clw'), LINK('dbxDS.clw')
List                            PROCEDURE(*QUEUE pQ),BOOL,PROC
Delete                          PROCEDURE(STRING dsid),BOOL,PROC
                              END

CdbxDS                        CLASS(IdbxDatastoreClass), TYPE, MODULE('dbxDS.clw'), LINK('dbxDS.clw')
Save                            PROCEDURE(STRING jsonfile),BOOL,PROC
Delete                          PROCEDURE(),BOOL,PROC
DatastoreId                     PROCEDURE(),STRING
Manager                         PROCEDURE(),*CdbxDSManager
                              END

CdbxTable                     CLASS(IdbxTableClass), TYPE, MODULE('dbxDS.clw'), LINK('dbxDS.clw')
m_COMIniter                     &CCOMIniter, PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), DERIVED

Initialize                      PROCEDURE(STRING oauth_token,STRING dsid,STRING tableid,STRING uKey),BOOL,PROC
ClearRecord                     PROCEDURE(),BOOL,PROC
GetField                        PROCEDURE(STRING fieldname),?
GetField                        PROCEDURE(STRING fieldname, *DATE datevalue, *TIME timevalue)
!SetField                        PROCEDURE(STRING fieldname,? fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*BYTE fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*SHORT fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*USHORT fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*DATE fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*TIME fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*DATE datevalue,*TIME timevalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*LONG fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*ULONG fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*SREAL fieldvalue),BOOL,PROC
SetField                        PROCEDURE(STRING fieldname,*REAL fieldvalue),BOOL,PROC 
SetField                        PROCEDURE(STRING fieldname,*BFLOAT4 fieldvalue),BOOL,PROC 
SetField                        PROCEDURE(STRING fieldname,*BFLOAT8 fieldvalue),BOOL,PROC 
SetField                        PROCEDURE(STRING fieldname,? fieldvalue),BOOL,PROC 
ReadRecord                      PROCEDURE(), VIRTUAL  !-- placeholder
WriteRecord                     PROCEDURE(), VIRTUAL  !-- placeholder
Insert                          PROCEDURE(),BOOL,PROC,VIRTUAL
Update                          PROCEDURE(),BOOL,PROC,VIRTUAL
Delete                          PROCEDURE(),BOOL,PROC,VIRTUAL
Select                          PROCEDURE(STRING colname,? colvalue,STRING operation,BOOL ignoreCase),BOOL,PROC,VIRTUAL
SelectAll                       PROCEDURE(),BOOL,PROC,VIRTUAL
Count                           PROCEDURE(),LONG
Next                            PROCEDURE(),BOOL,PROC,VIRTUAL
Previous                        PROCEDURE(),BOOL,PROC,VIRTUAL
Reset                           PROCEDURE(),BOOL,PROC
TableId                         PROCEDURE(),STRING
Datastore                       PROCEDURE(),*CdbxDS
Manager                         PROCEDURE(),*CdbxDSManager
                              END
