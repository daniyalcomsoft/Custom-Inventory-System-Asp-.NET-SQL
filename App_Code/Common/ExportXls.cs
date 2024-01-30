using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExportXls
/// </summary>
public  class ExportXls
{
    public ExportXls()
    {
        
    }
   

    public static bool CreateExcelDocument(DataSet ds, string excelFilename)
    {
        try
        {
            using (SpreadsheetDocument document = SpreadsheetDocument.Create(excelFilename, SpreadsheetDocumentType.Workbook))
            {
                WriteExcelFile(ds, document);
            }
            Trace.WriteLine("Successfully created: " + excelFilename);
            return true;
        }
        catch (Exception ex)
        {
            Trace.WriteLine("Failed, exception thrown: " + ex.Message);
            return false;
        }
    }

    private static void WriteExcelFile(DataSet ds, SpreadsheetDocument spreadsheet)
    {
        //  Create the Excel file contents.  This function is used when creating an Excel file either writing 
        //  to a file, or writing to a MemoryStream.
        spreadsheet.AddWorkbookPart();
        spreadsheet.WorkbookPart.Workbook = new DocumentFormat.OpenXml.Spreadsheet.Workbook();


        spreadsheet.WorkbookPart.Workbook.Append(new BookViews(new WorkbookView()));


        WorkbookStylesPart workbookStylesPart = spreadsheet.WorkbookPart.AddNewPart<WorkbookStylesPart>("rIdStyles");
        Stylesheet stylesheet = new Stylesheet();
        workbookStylesPart.Stylesheet = stylesheet;

        //  Loop through each of the DataTables in our DataSet, and create a new Excel Worksheet for each.
        uint worksheetNumber = 1;

        foreach (DataTable dt in ds.Tables)
        {
            //  For each worksheet you want to create
            string workSheetID = "rId" + worksheetNumber.ToString();
            string worksheetName = dt.TableName;

            WorksheetPart newWorksheetPart = spreadsheet.WorkbookPart.AddNewPart<WorksheetPart>();
            newWorksheetPart.Worksheet = new DocumentFormat.OpenXml.Spreadsheet.Worksheet();

            // create sheet data
            newWorksheetPart.Worksheet.AppendChild(new DocumentFormat.OpenXml.Spreadsheet.SheetData());

            // save worksheet
            WriteDataTableToExcelWorksheet(dt, newWorksheetPart);
            newWorksheetPart.Worksheet.Save();

            // create the worksheet to workbook relation
            if (worksheetNumber == 1)
                spreadsheet.WorkbookPart.Workbook.AppendChild(new DocumentFormat.OpenXml.Spreadsheet.Sheets());

            spreadsheet.WorkbookPart.Workbook.GetFirstChild<DocumentFormat.OpenXml.Spreadsheet.Sheets>().AppendChild(new DocumentFormat.OpenXml.Spreadsheet.Sheet()
            {
                Id = spreadsheet.WorkbookPart.GetIdOfPart(newWorksheetPart),
                SheetId = (uint)worksheetNumber,
                Name = dt.TableName
            });

            worksheetNumber++;
        }

        spreadsheet.WorkbookPart.Workbook.Save();
    }
    private static void WriteDataTableToExcelWorksheet(DataTable dt, WorksheetPart worksheetPart)
    {
        var worksheet = worksheetPart.Worksheet;
        var sheetData = worksheet.GetFirstChild<SheetData>();

        string cellValue = "";
        int numberOfColumns = dt.Columns.Count;
        bool[] IsNumericColumn = new bool[numberOfColumns];

        string[] excelColumnNames = new string[numberOfColumns];
        for (int n = 0; n < numberOfColumns; n++)
            excelColumnNames[n] = GetExcelColumnName(n);


        uint rowIndex = 1;

        var headerRow = new Row { RowIndex = rowIndex };  // add a row at the top of spreadsheet
        /////



        sheetData.Append(headerRow);

        for (int colInx = 0; colInx < numberOfColumns; colInx++)
        {
            DataColumn col = dt.Columns[colInx];
            AppendTextCell(excelColumnNames[colInx] + "1", col.ColumnName, headerRow);
            IsNumericColumn[colInx] = (col.DataType.FullName == "System.Decimal") || (col.DataType.FullName == "System.Int32");
        }

        //
        //  Now, step through each row of data in our DataTable...
        //
        double cellNumericValue = 0;
        foreach (DataRow dr in dt.Rows)
        {
            // ...create a new row, and append a set of this row's data to it.
            ++rowIndex;
            var newExcelRow = new Row { RowIndex = rowIndex };  // add a row at the top of spreadsheet
            sheetData.Append(newExcelRow);

            for (int colInx = 0; colInx < numberOfColumns; colInx++)
            {
                cellValue = dr.ItemArray[colInx].ToString();

                // Create cell with data
                if (IsNumericColumn[colInx])
                {
                    //  For numeric cells, make sure our input data IS a number, then write it out to the Excel file.
                    //  If this numeric value is NULL, then don't write anything to the Excel file.
                    cellNumericValue = 0;
                    if (double.TryParse(cellValue, out cellNumericValue))
                    {
                        cellValue = cellNumericValue.ToString();
                        AppendNumericCell(excelColumnNames[colInx] + rowIndex.ToString(), cellValue, newExcelRow);
                    }
                }
                else
                {
                    //  For text cells, just write the input data straight out to the Excel file.
                    AppendTextCell(excelColumnNames[colInx] + rowIndex.ToString(), cellValue, newExcelRow);
                }
            }
        }
    }

    private static void AppendTextCell(string cellReference, string cellStringValue, Row excelRow)
    {
        //  Add a new Excel Cell to our Row 
        Cell cell = new Cell() { CellReference = cellReference, DataType = CellValues.String };
        CellValue cellValue = new CellValue();
        cellValue.Text = cellStringValue;
        cell.Append(cellValue);
        excelRow.Append(cell);
    }

    private static void AppendNumericCell(string cellReference, string cellStringValue, Row excelRow)
    {
        //  Add a new Excel Cell to our Row 
        Cell cell = new Cell() { CellReference = cellReference };
        CellValue cellValue = new CellValue();
        cellValue.Text = cellStringValue;
        cell.Append(cellValue);
        excelRow.Append(cell);
    }
    private static string GetExcelColumnName(int columnIndex)
    {
        if (columnIndex < 26)
            return ((char)('A' + columnIndex)).ToString();

        char firstChar = (char)('A' + (columnIndex / 26) - 1);
        char secondChar = (char)('A' + (columnIndex % 26));

        return string.Format("{0}{1}", firstChar, secondChar);
    }
}