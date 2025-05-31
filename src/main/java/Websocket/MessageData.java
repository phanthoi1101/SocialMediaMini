package Websocket;

public class MessageData {
	private String status;
    private String message;
    private String fileName;
    private String fileType;
    private String fileData;

    // Getters và Setters
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public String getFileData() { return fileData; }
    public void setFileData(String fileData) { this.fileData = fileData; }
	public MessageData(String status, String message, String fileName, String fileType, String fileData) {
		super();
		this.status = status;
		this.message = message;
		this.fileName = fileName;
		this.fileType = fileType;
		this.fileData = fileData;
	}
	public MessageData() {
		super();
		// TODO Auto-generated constructor stub
	}
}
