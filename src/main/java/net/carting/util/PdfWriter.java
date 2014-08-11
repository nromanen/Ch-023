package net.carting.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.tool.xml.XMLWorkerHelper;

import java.io.*;
import java.nio.charset.StandardCharsets;

/**
 * Carting
 * Created by manson on 8/7/14.
 */
public class PdfWriter {


    public static void createStartStatement(String path, String html) throws IOException, DocumentException {
        InputStream stream = new ByteArrayInputStream(html.getBytes(StandardCharsets.UTF_8));
        Document document = new Document();
        FileOutputStream fos = new FileOutputStream(path);
        com.itextpdf.text.pdf.PdfWriter writer = com.itextpdf.text.pdf.PdfWriter.getInstance(document, fos);
        document.open();
        XMLWorkerHelper.getInstance().parseXHtml(
                writer,
                document,
                stream
        );
        document.close();
        fos.close();
        stream.close();
    }
}