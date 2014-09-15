/**
 * Created by manson on 11.09.14.
 */
$(document).ready(function(){
    $('#link').attr('href', 'data:application/pdf;base64,' + $('#pdf').val());
    var pdfBase64 = $('#pdf').val();

    var scale = 1.2; //Set this to whatever you want. This is basically the "zoom" factor for the PDF.

    /**
     * Converts a base64 string into a Uint8Array
     */
    function base64ToUint8Array(base64) {
        var raw = atob(base64); //This is a native function that decodes a base64-encoded string.
        var uint8Array = new Uint8Array(new ArrayBuffer(raw.length));
        for(var i = 0; i < raw.length; i++) {
            uint8Array[i] = raw.charCodeAt(i);
        }
        return uint8Array;
    }

    function loadPdf(pdfData) {
        PDFJS.disableWorker = true; //Not using web workers. Not disabling results in an error. This line is
        //missing in the example code for rendering a pdf.
        var pdf = PDFJS.getDocument(pdfData);
        pdf.then(renderPdf);
    }

    function renderPdf(pdf) {
        pdf.getPage(1).then(renderPage);
    }

    function renderPage(page) {
        var viewport = page.getViewport(scale);
        var $canvas = jQuery("<canvas></canvas>");

        //Set the canvas height and width to the height and width of the viewport
        var canvas = $canvas.get(0);
        var context = canvas.getContext("2d");
        canvas.height = viewport.height;
        canvas.width = viewport.width;

        //Append the canvas to the pdf container div
        jQuery("#pdfContainer").append($canvas);

        page.getTextContent().then(function() {
            var renderContext = {
                canvasContext: context,
                viewport: viewport
            };
            page.render(renderContext);
        });
    }

    var pdfData = base64ToUint8Array(pdfBase64);
    loadPdf(pdfData);
});