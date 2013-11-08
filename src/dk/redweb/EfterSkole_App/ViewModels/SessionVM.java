package dk.redweb.EfterSkole_App.ViewModels;

import com.google.android.gms.maps.model.LatLng;
import dk.redweb.EfterSkole_App.Model.Session;
import dk.redweb.EfterSkole_App.StringUtils;
import org.joda.time.LocalDate;
import org.joda.time.LocalTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.Locale;

/**
 * Created by Redweb with IntelliJ IDEA.
 * Date: 9/19/13
 * Time: 3:36 PM
 */
public class SessionVM {
    Locale locale = new Locale("da_DK", "da_DK");
    private Session _session;

    public int SessionId(){
        return _session.SessionId;
    }

    public String Title(){
        if (_session.Title.length() != 0){
            return _session.Title;
        } else {
            return _session.Event().Title;
        }
    }

    public String SummaryWithHtml(){
        if(_session.Event().Summary.length() != 0){
            return StringUtils.stripJoomlaTags(_session.Event().Summary);
        } else {
            return StringUtils.stripJoomlaTags(_session.Event().Details);
        }
    }

    public String SummaryWithoutHtml(){
        if(_session.Event().Summary.length() != 0) {
            return StringUtils.stripHtmlAndJoomla(_session.Event().Summary);
        } else {
            return StringUtils.stripHtmlAndJoomla(_session.Event().Details);
        }
    }

    public String DetailsWithHtml(){
        return StringUtils.stripJoomlaTags(_session.Event().Details + "<br/>" + _session.Details);
    }

    public String DetailsWithoutHtml(){
        return StringUtils.stripHtmlAndJoomla(_session.Event().Details + "<br/>" + _session.Details);
    }

    public LocalDate StartDate(){
        return _session.StartDate;
    }

    public LocalTime StartTime(){
        return _session.StartTime;
    }

    public String StartDateWithPattern(String pattern){
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(pattern).withLocale(locale);
        return dateTimeFormatter.print(_session.StartDate);
    }

    public String StartTimeAsString(){
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("HH:mm").withLocale(locale);
        return dateTimeFormatter.print(_session.StartTime);
    }

    public LocalDate EndDate(){
        return _session.EndDate;
    }

    public LocalTime EndTime(){
        return _session.EndTime;
    }

    public String EndDateWithPattern(String pattern){
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(pattern).withLocale(locale);
        return dateTimeFormatter.print(_session.EndDate);
    }

    public String EndTimeAsString(){
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("HH:mm").withLocale(locale);
        return dateTimeFormatter.print(_session.EndTime);
    }

    public String SubmissionPath(){
        return _session.Event().Submission;
    }

    public String ImagePath(){
        return _session.Event().Imagepath;
    }

    public String Venue(){
        return _session.Venue().Title;
    }

    public Double Latitude(){
        return _session.Venue().Latitude;
    }

    public Double Longitude(){
        return _session.Venue().Longitude;
    }

    public LatLng Location(){
        return new LatLng(Latitude(), Longitude());
    }

    public SessionVM(Session session) {
        _session = session;
    }
}