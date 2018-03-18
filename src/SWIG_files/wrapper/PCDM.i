/*
Copyright 2008-2018 Thomas Paviot (tpaviot@gmail.com)


This file is part of pythonOCC.
pythonOCC is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pythonOCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.

*/
%define PCDMDOCSTRING
"No docstring provided."
%enddef
%module (package="OCC.Core", docstring=PCDMDOCSTRING) PCDM

#pragma SWIG nowarn=504,325,503

%{
#ifdef WNT
#pragma warning(disable : 4716)
#endif
%}

%include ../common/CommonIncludes.i
%include ../common/ExceptionCatcher.i
%include ../common/FunctionTransformers.i
%include ../common/Operators.i


%include PCDM_headers.i


%pythoncode {
def register_handle(handle, base_object):
    """
    Inserts the handle into the base object to
    prevent memory corruption in certain cases
    """
    try:
        if base_object.IsKind("Standard_Transient"):
            base_object.thisHandle = handle
            base_object.thisown = False
    except:
        pass
};

/* templates */
/* templates */
%define Handle(Class) opencascade::handle<Class>
%enddef
%template(PCDM_SequenceOfReference) NCollection_Sequence <PCDM_Reference>;
%template(PCDM_SequenceOfDocument) NCollection_Sequence <Handle(PCDM_Document)>;
/* end templates declaration */

/* end templates declaration */

/* typedefs */
typedef NCollection_Sequence <PCDM_Reference> PCDM_SequenceOfReference;
typedef NCollection_Sequence <Handle_PCDM_Document> PCDM_SequenceOfDocument;
typedef Storage_BaseDriver * PCDM_BaseDriverPointer;
/* end typedefs declaration */

/* public enums */
enum PCDM_StoreStatus {
	PCDM_SS_OK = 0,
	PCDM_SS_DriverFailure = 1,
	PCDM_SS_WriteFailure = 2,
	PCDM_SS_Failure = 3,
	PCDM_SS_Doc_IsNull = 4,
	PCDM_SS_No_Obj = 5,
	PCDM_SS_Info_Section_Error = 6,
};

enum PCDM_TypeOfFileDriver {
	PCDM_TOFD_File = 0,
	PCDM_TOFD_CmpFile = 1,
	PCDM_TOFD_XmlFile = 2,
	PCDM_TOFD_Unknown = 3,
};

enum PCDM_ReaderStatus {
	PCDM_RS_OK = 0,
	PCDM_RS_NoDriver = 1,
	PCDM_RS_UnknownFileDriver = 2,
	PCDM_RS_OpenError = 3,
	PCDM_RS_NoVersion = 4,
	PCDM_RS_NoSchema = 5,
	PCDM_RS_NoDocument = 6,
	PCDM_RS_ExtensionFailure = 7,
	PCDM_RS_WrongStreamMode = 8,
	PCDM_RS_FormatFailure = 9,
	PCDM_RS_TypeFailure = 10,
	PCDM_RS_TypeNotFoundInSchema = 11,
	PCDM_RS_UnrecognizedFileFormat = 12,
	PCDM_RS_MakeFailure = 13,
	PCDM_RS_PermissionDenied = 14,
	PCDM_RS_DriverFailure = 15,
	PCDM_RS_AlreadyRetrievedAndModified = 16,
	PCDM_RS_AlreadyRetrieved = 17,
	PCDM_RS_UnknownDocument = 18,
	PCDM_RS_WrongResource = 19,
	PCDM_RS_ReaderException = 20,
	PCDM_RS_NoModel = 21,
};

/* end public enums declaration */

%rename(pcdm) PCDM;
%nodefaultctor PCDM;
class PCDM {
	public:
		%feature("compactdefaultargs") FileDriverType;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_AsciiString &
	:param aBaseDriver:
	:type aBaseDriver: PCDM_BaseDriverPointer &
	:rtype: PCDM_TypeOfFileDriver
") FileDriverType;
		static PCDM_TypeOfFileDriver FileDriverType (const TCollection_AsciiString & aFileName,PCDM_BaseDriverPointer & aBaseDriver);
		%feature("compactdefaultargs") FileDriverType;
		%feature("autodoc", "	:param theIStream:
	:type theIStream: Standard_IStream &
	:param theBaseDriver:
	:type theBaseDriver: PCDM_BaseDriverPointer &
	:rtype: PCDM_TypeOfFileDriver
") FileDriverType;
		static PCDM_TypeOfFileDriver FileDriverType (Standard_IStream & theIStream,PCDM_BaseDriverPointer & theBaseDriver);
};


%extend PCDM {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_Document;
class PCDM_Document : public Standard_Persistent {
	public:
};


%extend PCDM_Document {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_Document(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_Document::Handle_PCDM_Document %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_Document;
class Handle_PCDM_Document : public Handle_Standard_Persistent {

    public:
        // constructors
        Handle_PCDM_Document();
        Handle_PCDM_Document(const Handle_PCDM_Document &aHandle);
        Handle_PCDM_Document(const PCDM_Document *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_Document DownCast(const Handle_Standard_Persistent &AnObject);

};

%extend Handle_PCDM_Document {
    PCDM_Document* _get_reference() {
    return (PCDM_Document*)$self->get();
    }
};

%extend Handle_PCDM_Document {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_Document {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_ReadWriter;
class PCDM_ReadWriter : public Standard_Transient {
	public:
		%feature("compactdefaultargs") Version;
		%feature("autodoc", "	* returns PCDM_ReadWriter_1.

	:rtype: TCollection_AsciiString
") Version;
		virtual TCollection_AsciiString Version ();
		%feature("compactdefaultargs") WriteReferenceCounter;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: void
") WriteReferenceCounter;
		virtual void WriteReferenceCounter (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") WriteReferences;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param theReferencerFileName:
	:type theReferencerFileName: TCollection_ExtendedString &
	:rtype: void
") WriteReferences;
		virtual void WriteReferences (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument,const TCollection_ExtendedString & theReferencerFileName);
		%feature("compactdefaultargs") WriteExtensions;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: void
") WriteExtensions;
		virtual void WriteExtensions (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") WriteVersion;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: void
") WriteVersion;
		virtual void WriteVersion (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") ReadReferenceCounter;
		%feature("autodoc", "	:param theFileName:
	:type theFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") ReadReferenceCounter;
		virtual Standard_Integer ReadReferenceCounter (const TCollection_ExtendedString & theFileName,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadReferences;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theReferences:
	:type theReferences: PCDM_SequenceOfReference &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: void
") ReadReferences;
		virtual void ReadReferences (const TCollection_ExtendedString & aFileName,PCDM_SequenceOfReference & theReferences,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadExtensions;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theExtensions:
	:type theExtensions: TColStd_SequenceOfExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: void
") ReadExtensions;
		virtual void ReadExtensions (const TCollection_ExtendedString & aFileName,TColStd_SequenceOfExtendedString & theExtensions,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadDocumentVersion;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") ReadDocumentVersion;
		virtual Standard_Integer ReadDocumentVersion (const TCollection_ExtendedString & aFileName,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") Open;
		%feature("autodoc", "	:param aDriver:
	:type aDriver: Storage_BaseDriver &
	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param anOpenMode:
	:type anOpenMode: Storage_OpenMode
	:rtype: void
") Open;
		static void Open (Storage_BaseDriver & aDriver,const TCollection_ExtendedString & aFileName,const Storage_OpenMode anOpenMode);
		%feature("compactdefaultargs") Reader;
		%feature("autodoc", "	* returns the convenient Reader for a File.

	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:rtype: Handle_PCDM_ReadWriter
") Reader;
		static Handle_PCDM_ReadWriter Reader (const TCollection_ExtendedString & aFileName);
		%feature("compactdefaultargs") Writer;
		%feature("autodoc", "	:rtype: Handle_PCDM_ReadWriter
") Writer;
		static Handle_PCDM_ReadWriter Writer ();
		%feature("compactdefaultargs") WriteFileFormat;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: void
") WriteFileFormat;
		static void WriteFileFormat (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") FileFormat;
		%feature("autodoc", "	* tries to get a format in the file. returns an empty string if the file could not be read or does not have a FileFormat information.

	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:rtype: TCollection_ExtendedString
") FileFormat;
		static TCollection_ExtendedString FileFormat (const TCollection_ExtendedString & aFileName);
		%feature("compactdefaultargs") FileFormat;
		%feature("autodoc", "	* tries to get a format from the stream. returns an empty string if the file could not be read or does not have a FileFormat information.

	:param theIStream:
	:type theIStream: Standard_IStream &
	:param theData:
	:type theData: Handle_Storage_Data &
	:rtype: TCollection_ExtendedString
") FileFormat;
		static TCollection_ExtendedString FileFormat (Standard_IStream & theIStream,Handle_Storage_Data & theData);
};


%extend PCDM_ReadWriter {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_ReadWriter(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_ReadWriter::Handle_PCDM_ReadWriter %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_ReadWriter;
class Handle_PCDM_ReadWriter : public Handle_Standard_Transient {

    public:
        // constructors
        Handle_PCDM_ReadWriter();
        Handle_PCDM_ReadWriter(const Handle_PCDM_ReadWriter &aHandle);
        Handle_PCDM_ReadWriter(const PCDM_ReadWriter *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_ReadWriter DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_ReadWriter {
    PCDM_ReadWriter* _get_reference() {
    return (PCDM_ReadWriter*)$self->get();
    }
};

%extend Handle_PCDM_ReadWriter {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_ReadWriter {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_Reader;
class PCDM_Reader : public Standard_Transient {
	public:
		%feature("compactdefaultargs") CreateDocument;
		%feature("autodoc", "	* this method is called by the framework before the read method.

	:rtype: Handle_CDM_Document
") CreateDocument;
		virtual Handle_CDM_Document CreateDocument ();
		%feature("compactdefaultargs") Read;
		%feature("autodoc", "	* retrieves the content of the file into a new Document.

	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param aNewDocument:
	:type aNewDocument: Handle_CDM_Document &
	:param anApplication:
	:type anApplication: Handle_CDM_Application &
	:rtype: void
") Read;
		virtual void Read (const TCollection_ExtendedString & aFileName,const Handle_CDM_Document & aNewDocument,const Handle_CDM_Application & anApplication);
		%feature("compactdefaultargs") Read;
		%feature("autodoc", "	:param theIStream:
	:type theIStream: Standard_IStream &
	:param theStorageData:
	:type theStorageData: Handle_Storage_Data &
	:param theDoc:
	:type theDoc: Handle_CDM_Document &
	:param theApplication:
	:type theApplication: Handle_CDM_Application &
	:rtype: void
") Read;
		virtual void Read (Standard_IStream & theIStream,const Handle_Storage_Data & theStorageData,const Handle_CDM_Document & theDoc,const Handle_CDM_Application & theApplication);
		%feature("compactdefaultargs") GetStatus;
		%feature("autodoc", "	:rtype: PCDM_ReaderStatus
") GetStatus;
		PCDM_ReaderStatus GetStatus ();
};


%extend PCDM_Reader {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_Reader(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_Reader::Handle_PCDM_Reader %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_Reader;
class Handle_PCDM_Reader : public Handle_Standard_Transient {

    public:
        // constructors
        Handle_PCDM_Reader();
        Handle_PCDM_Reader(const Handle_PCDM_Reader &aHandle);
        Handle_PCDM_Reader(const PCDM_Reader *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_Reader DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_Reader {
    PCDM_Reader* _get_reference() {
    return (PCDM_Reader*)$self->get();
    }
};

%extend Handle_PCDM_Reader {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_Reader {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_Reference;
class PCDM_Reference {
	public:
		%feature("compactdefaultargs") PCDM_Reference;
		%feature("autodoc", "	:rtype: None
") PCDM_Reference;
		 PCDM_Reference ();
		%feature("compactdefaultargs") PCDM_Reference;
		%feature("autodoc", "	:param aReferenceIdentifier:
	:type aReferenceIdentifier: int
	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param aDocumentVersion:
	:type aDocumentVersion: int
	:rtype: None
") PCDM_Reference;
		 PCDM_Reference (const Standard_Integer aReferenceIdentifier,const TCollection_ExtendedString & aFileName,const Standard_Integer aDocumentVersion);
		%feature("compactdefaultargs") ReferenceIdentifier;
		%feature("autodoc", "	:rtype: int
") ReferenceIdentifier;
		Standard_Integer ReferenceIdentifier ();
		%feature("compactdefaultargs") FileName;
		%feature("autodoc", "	:rtype: TCollection_ExtendedString
") FileName;
		TCollection_ExtendedString FileName ();
		%feature("compactdefaultargs") DocumentVersion;
		%feature("autodoc", "	:rtype: int
") DocumentVersion;
		Standard_Integer DocumentVersion ();
};


%extend PCDM_Reference {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_ReferenceIterator;
class PCDM_ReferenceIterator : public Standard_Transient {
	public:
		%feature("compactdefaultargs") PCDM_ReferenceIterator;
		%feature("autodoc", "	* Warning! The constructor does not initialization.

	:param theMessageDriver:
	:type theMessageDriver: Handle_CDM_MessageDriver &
	:rtype: None
") PCDM_ReferenceIterator;
		 PCDM_ReferenceIterator (const Handle_CDM_MessageDriver & theMessageDriver);
		%feature("compactdefaultargs") LoadReferences;
		%feature("autodoc", "	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param aMetaData:
	:type aMetaData: Handle_CDM_MetaData &
	:param anApplication:
	:type anApplication: Handle_CDM_Application &
	:param UseStorageConfiguration:
	:type UseStorageConfiguration: bool
	:rtype: None
") LoadReferences;
		void LoadReferences (const Handle_CDM_Document & aDocument,const Handle_CDM_MetaData & aMetaData,const Handle_CDM_Application & anApplication,const Standard_Boolean UseStorageConfiguration);
		%feature("compactdefaultargs") Init;
		%feature("autodoc", "	:param aMetaData:
	:type aMetaData: Handle_CDM_MetaData &
	:rtype: void
") Init;
		virtual void Init (const Handle_CDM_MetaData & aMetaData);
};


%extend PCDM_ReferenceIterator {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_ReferenceIterator(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_ReferenceIterator::Handle_PCDM_ReferenceIterator %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_ReferenceIterator;
class Handle_PCDM_ReferenceIterator : public Handle_Standard_Transient {

    public:
        // constructors
        Handle_PCDM_ReferenceIterator();
        Handle_PCDM_ReferenceIterator(const Handle_PCDM_ReferenceIterator &aHandle);
        Handle_PCDM_ReferenceIterator(const PCDM_ReferenceIterator *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_ReferenceIterator DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_ReferenceIterator {
    PCDM_ReferenceIterator* _get_reference() {
    return (PCDM_ReferenceIterator*)$self->get();
    }
};

%extend Handle_PCDM_ReferenceIterator {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_ReferenceIterator {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_Writer;
class PCDM_Writer : public Standard_Transient {
	public:
		%feature("compactdefaultargs") Write;
		%feature("autodoc", "	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:rtype: void
") Write;
		virtual void Write (const Handle_CDM_Document & aDocument,const TCollection_ExtendedString & aFileName);
		%feature("compactdefaultargs") Write;
		%feature("autodoc", "	* Write <theDocument> to theOStream

	:param theDocument:
	:type theDocument: Handle_CDM_Document &
	:param theOStream:
	:type theOStream: Standard_OStream &
	:rtype: void
") Write;
		virtual void Write (const Handle_CDM_Document & theDocument,Standard_OStream & theOStream);
};


%extend PCDM_Writer {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_Writer(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_Writer::Handle_PCDM_Writer %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_Writer;
class Handle_PCDM_Writer : public Handle_Standard_Transient {

    public:
        // constructors
        Handle_PCDM_Writer();
        Handle_PCDM_Writer(const Handle_PCDM_Writer &aHandle);
        Handle_PCDM_Writer(const PCDM_Writer *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_Writer DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_Writer {
    PCDM_Writer* _get_reference() {
    return (PCDM_Writer*)$self->get();
    }
};

%extend Handle_PCDM_Writer {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_Writer {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_ReadWriter_1;
class PCDM_ReadWriter_1 : public PCDM_ReadWriter {
	public:
		%feature("compactdefaultargs") PCDM_ReadWriter_1;
		%feature("autodoc", "	:rtype: None
") PCDM_ReadWriter_1;
		 PCDM_ReadWriter_1 ();
		%feature("compactdefaultargs") Version;
		%feature("autodoc", "	* returns PCDM_ReadWriter_1.

	:rtype: TCollection_AsciiString
") Version;
		TCollection_AsciiString Version ();
		%feature("compactdefaultargs") WriteReferenceCounter;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: None
") WriteReferenceCounter;
		void WriteReferenceCounter (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") WriteReferences;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param theReferencerFileName:
	:type theReferencerFileName: TCollection_ExtendedString &
	:rtype: None
") WriteReferences;
		void WriteReferences (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument,const TCollection_ExtendedString & theReferencerFileName);
		%feature("compactdefaultargs") WriteExtensions;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: None
") WriteExtensions;
		void WriteExtensions (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") WriteVersion;
		%feature("autodoc", "	:param aData:
	:type aData: Handle_Storage_Data &
	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: None
") WriteVersion;
		void WriteVersion (const Handle_Storage_Data & aData,const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") ReadReferenceCounter;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") ReadReferenceCounter;
		Standard_Integer ReadReferenceCounter (const TCollection_ExtendedString & aFileName,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadReferences;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theReferences:
	:type theReferences: PCDM_SequenceOfReference &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: None
") ReadReferences;
		void ReadReferences (const TCollection_ExtendedString & aFileName,PCDM_SequenceOfReference & theReferences,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadExtensions;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theExtensions:
	:type theExtensions: TColStd_SequenceOfExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: None
") ReadExtensions;
		void ReadExtensions (const TCollection_ExtendedString & aFileName,TColStd_SequenceOfExtendedString & theExtensions,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReadDocumentVersion;
		%feature("autodoc", "	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") ReadDocumentVersion;
		Standard_Integer ReadDocumentVersion (const TCollection_ExtendedString & aFileName,const Handle_CDM_MessageDriver & theMsgDriver);
};


%extend PCDM_ReadWriter_1 {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_ReadWriter_1(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_ReadWriter_1::Handle_PCDM_ReadWriter_1 %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_ReadWriter_1;
class Handle_PCDM_ReadWriter_1 : public Handle_PCDM_ReadWriter {

    public:
        // constructors
        Handle_PCDM_ReadWriter_1();
        Handle_PCDM_ReadWriter_1(const Handle_PCDM_ReadWriter_1 &aHandle);
        Handle_PCDM_ReadWriter_1(const PCDM_ReadWriter_1 *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_ReadWriter_1 DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_ReadWriter_1 {
    PCDM_ReadWriter_1* _get_reference() {
    return (PCDM_ReadWriter_1*)$self->get();
    }
};

%extend Handle_PCDM_ReadWriter_1 {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_ReadWriter_1 {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_RetrievalDriver;
class PCDM_RetrievalDriver : public PCDM_Reader {
	public:
		%feature("compactdefaultargs") DocumentVersion;
		%feature("autodoc", "	:param theFileName:
	:type theFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") DocumentVersion;
		static Standard_Integer DocumentVersion (const TCollection_ExtendedString & theFileName,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") ReferenceCounter;
		%feature("autodoc", "	:param theFileName:
	:type theFileName: TCollection_ExtendedString &
	:param theMsgDriver:
	:type theMsgDriver: Handle_CDM_MessageDriver &
	:rtype: int
") ReferenceCounter;
		static Standard_Integer ReferenceCounter (const TCollection_ExtendedString & theFileName,const Handle_CDM_MessageDriver & theMsgDriver);
		%feature("compactdefaultargs") SetFormat;
		%feature("autodoc", "	:param aformat:
	:type aformat: TCollection_ExtendedString &
	:rtype: None
") SetFormat;
		void SetFormat (const TCollection_ExtendedString & aformat);
		%feature("compactdefaultargs") GetFormat;
		%feature("autodoc", "	:rtype: TCollection_ExtendedString
") GetFormat;
		TCollection_ExtendedString GetFormat ();
};


%extend PCDM_RetrievalDriver {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_RetrievalDriver(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_RetrievalDriver::Handle_PCDM_RetrievalDriver %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_RetrievalDriver;
class Handle_PCDM_RetrievalDriver : public Handle_PCDM_Reader {

    public:
        // constructors
        Handle_PCDM_RetrievalDriver();
        Handle_PCDM_RetrievalDriver(const Handle_PCDM_RetrievalDriver &aHandle);
        Handle_PCDM_RetrievalDriver(const PCDM_RetrievalDriver *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_RetrievalDriver DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_RetrievalDriver {
    PCDM_RetrievalDriver* _get_reference() {
    return (PCDM_RetrievalDriver*)$self->get();
    }
};

%extend Handle_PCDM_RetrievalDriver {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_RetrievalDriver {
	%pythoncode {
	__repr__ = _dumps_object
	}
};
%nodefaultctor PCDM_StorageDriver;
class PCDM_StorageDriver : public PCDM_Writer {
	public:
		%feature("compactdefaultargs") Make;
		%feature("autodoc", "	* raises NotImplemented.

	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:rtype: Handle_PCDM_Document
") Make;
		virtual Handle_PCDM_Document Make (const Handle_CDM_Document & aDocument);
		%feature("compactdefaultargs") Make;
		%feature("autodoc", "	* By default, puts in the Sequence the document returns by the previous Make method.

	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param Documents:
	:type Documents: PCDM_SequenceOfDocument &
	:rtype: void
") Make;
		virtual void Make (const Handle_CDM_Document & aDocument,PCDM_SequenceOfDocument & Documents);
		%feature("compactdefaultargs") Write;
		%feature("autodoc", "	* Warning! raises DriverError if an error occurs during inside the Make method. stores the content of the Document into a new file. //! by default Write will use Make method to build a persistent document and the Schema method to write the persistent document.

	:param aDocument:
	:type aDocument: Handle_CDM_Document &
	:param aFileName:
	:type aFileName: TCollection_ExtendedString &
	:rtype: void
") Write;
		virtual void Write (const Handle_CDM_Document & aDocument,const TCollection_ExtendedString & aFileName);
		%feature("compactdefaultargs") Write;
		%feature("autodoc", "	* Write <theDocument> to theOStream

	:param theDocument:
	:type theDocument: Handle_CDM_Document &
	:param theOStream:
	:type theOStream: Standard_OStream &
	:rtype: void
") Write;
		virtual void Write (const Handle_CDM_Document & theDocument,Standard_OStream & theOStream);
		%feature("compactdefaultargs") SetFormat;
		%feature("autodoc", "	:param aformat:
	:type aformat: TCollection_ExtendedString &
	:rtype: None
") SetFormat;
		void SetFormat (const TCollection_ExtendedString & aformat);
		%feature("compactdefaultargs") GetFormat;
		%feature("autodoc", "	:rtype: TCollection_ExtendedString
") GetFormat;
		TCollection_ExtendedString GetFormat ();
		%feature("compactdefaultargs") IsError;
		%feature("autodoc", "	:rtype: bool
") IsError;
		Standard_Boolean IsError ();
		%feature("compactdefaultargs") SetIsError;
		%feature("autodoc", "	:param theIsError:
	:type theIsError: bool
	:rtype: None
") SetIsError;
		void SetIsError (const Standard_Boolean theIsError);
		%feature("compactdefaultargs") GetStoreStatus;
		%feature("autodoc", "	:rtype: PCDM_StoreStatus
") GetStoreStatus;
		PCDM_StoreStatus GetStoreStatus ();
		%feature("compactdefaultargs") SetStoreStatus;
		%feature("autodoc", "	:param theStoreStatus:
	:type theStoreStatus: PCDM_StoreStatus
	:rtype: None
") SetStoreStatus;
		void SetStoreStatus (const PCDM_StoreStatus theStoreStatus);
};


%extend PCDM_StorageDriver {
	%pythoncode {
		def GetHandle(self):
		    try:
		        return self.thisHandle
		    except:
		        self.thisHandle = Handle_PCDM_StorageDriver(self)
		        self.thisown = False
		        return self.thisHandle
	}
};

%pythonappend Handle_PCDM_StorageDriver::Handle_PCDM_StorageDriver %{
    # register the handle in the base object
    if len(args) > 0:
        register_handle(self, args[0])
%}

%nodefaultctor Handle_PCDM_StorageDriver;
class Handle_PCDM_StorageDriver : public Handle_PCDM_Writer {

    public:
        // constructors
        Handle_PCDM_StorageDriver();
        Handle_PCDM_StorageDriver(const Handle_PCDM_StorageDriver &aHandle);
        Handle_PCDM_StorageDriver(const PCDM_StorageDriver *anItem);
        void Nullify();
        Standard_Boolean IsNull() const;
        static const Handle_PCDM_StorageDriver DownCast(const Handle_Standard_Transient &AnObject);

};

%extend Handle_PCDM_StorageDriver {
    PCDM_StorageDriver* _get_reference() {
    return (PCDM_StorageDriver*)$self->get();
    }
};

%extend Handle_PCDM_StorageDriver {
     %pythoncode {
         def GetObject(self):
             obj = self._get_reference()
             register_handle(self, obj)
             return obj
     }
};

%extend PCDM_StorageDriver {
	%pythoncode {
	__repr__ = _dumps_object
	}
};