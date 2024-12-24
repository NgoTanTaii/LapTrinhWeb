package Entity;

public class Video {
    private int propertyId;
    private String videoUrl;

    public Video(int propertyId, String videoUrl) {
        this.propertyId = propertyId;
        this.videoUrl = videoUrl;
    }

    public Video() {

    }

    public int getPropertyId() {
        return propertyId;

    }

    @Override
    public String toString() {
        return "Video{" +
                "propertyId=" + propertyId +
                ", videoUrl='" + videoUrl + '\'' +
                '}';
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
}
