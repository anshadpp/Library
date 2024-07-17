package sample.user.dashboard.model;


public class Books {
    private int id;
    private String book_name;
    private String author_name;
    private String pdf_file_path;

    public Books(int id, String book_name, String author_name, String pdf_file_path) {
        this.id = id;
        this.book_name = book_name;
        this.author_name = author_name;
        this.pdf_file_path = pdf_file_path;
    }

    public int getId() {
        return id;
    }

    public String getBook_name() {
        return book_name;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public String getPdf_file_path() {
        return pdf_file_path;
    }
}
