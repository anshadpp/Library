function openPdf(pdfData) {
    const pdfUrl = 'data:application/pdf;base64,' + pdfData;
    // Open a new window/tab with the PDF data
    window.open(pdfUrl, '_blank');
	window.open('pdf?id=${book.book_id}', '_blank')
}
