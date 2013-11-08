package dk.redweb.EfterSkole_App.ViewControllers.Article.ArticleDetail;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import dk.redweb.EfterSkole_App.AppearanceHelper;
import dk.redweb.EfterSkole_App.MyLog;
import dk.redweb.EfterSkole_App.R;
import dk.redweb.EfterSkole_App.StaticNames.EXTRA;
import dk.redweb.EfterSkole_App.StaticNames.LOOK;
import dk.redweb.EfterSkole_App.StaticNames.PAGE;
import dk.redweb.EfterSkole_App.ViewControllers.BasePageFragment;
import dk.redweb.EfterSkole_App.ViewModels.ArticleVM;
import dk.redweb.EfterSkole_App.Views.FlexibleButton;
import dk.redweb.EfterSkole_App.Views.NavBarBox;
import dk.redweb.EfterSkole_App.XmlHandling.XmlNode;

/**
 * Created by Redweb with IntelliJ IDEA.
 * Date: 9/19/13
 * Time: 9:53 AM
 */
public class ArticleDetailFragment extends BasePageFragment {

    public ArticleDetailFragment(XmlNode page) {
        super(page);
    }

    @Override
    public View onCreateView(LayoutInflater inflate, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflate, container, R.layout.frag_articledetail);

        int articleId = 0;
        try {
            articleId = _page.getIntegerFromNode(EXTRA.ARTICLEID);
        } catch (NoSuchFieldException e) {
            MyLog.e("Exception when getting articleId for new ArticleDetail fragment from page xml", e);
        }

        setAppearance();

        ArticleVM article = _db.Articles.getVMFromId(articleId);

        try {
            if(_page.hasChild(PAGE.RETURNONTAP) && _page.getBoolFromNode(PAGE.RETURNONTAP)){
                LinearLayout lnrBackground = (LinearLayout)findViewById(R.id.articleDetail_lnrMainView);
                lnrBackground.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        getFragmentManager().popBackStack();
                    }
                });
            }
        } catch (NoSuchFieldException e) {
            MyLog.e("Exception when attempting to get ReturnOnTap attribute from page xml", e);
        }

        TextView title = (TextView)findViewById(R.id.articleDetail_lblTitle);
        if(article.ArticleId() != -1){
            title.setText(article.Title());
        } else {
            title.setText("Sorry.\r\nThis article has been removed.");
        }

        WebView webBody = (WebView)findViewById(R.id.articleDetail_webBody);
        TextView txtBody = (TextView)findViewById(R.id.articleDetail_lblBody);
        try {
            if(_page.hasChild(PAGE.BODYUSESHTML) && _page.getBoolFromNode(PAGE.BODYUSESHTML)) {
                webBody.loadDataWithBaseURL(null, article.FullTextWithHtml(), "text/html", "UTF-8", null);
                txtBody.setVisibility(View.GONE);
            } else {
                txtBody.setText(article.FullTextWithoutHtml());
                webBody.setVisibility(View.GONE);
            }
        } catch (Exception e) {
            MyLog.e("Exception in ArticleDetailActivity:onCreate when attempting to determine body type (web vs. text)", e);
        }

        try {
            FlexibleButton flxBackButton = (FlexibleButton)findViewById(R.id.articledetail_flxBackButton);
            if(_page.hasChild(PAGE.RETURNBUTTON) && _page.getBoolFromNode(PAGE.RETURNBUTTON)){
                flxBackButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        getFragmentManager().popBackStack();
                    }
                });
            } else {
                flxBackButton.setVisibility(View.GONE);
            }
        } catch (NoSuchFieldException e) {
            MyLog.e("Exception when getting ReturnButton attribute from page xml", e);
        }

        return _view;
    }

    @Override
    public void onResume(){
        super.onResume();

        NavBarBox navBarBox = (NavBarBox)getActivity().findViewById(R.id.navbar);
        navBarBox.setUpButtonTargetForThisPage(_page, null);
    }

    private void setAppearance(){
        try {
            AppearanceHelper helper = new AppearanceHelper(_view.getContext(), _locallook, _globallook);


            ScrollView mainViewLayout = (ScrollView)findViewById(R.id.sessionDetail_scrMainView);
            helper.setViewBackgroundTileImageOrColor(mainViewLayout, LOOK.ARTICLEDETAIL_BACKGROUNDIMAGE, LOOK.ARTICLEDETAIL_BACKGROUNDCOLOR, LOOK.GLOBAL_BACKCOLOR);

            TextView txtTitle = (TextView)findViewById(R.id.articleDetail_lblTitle);
            helper.setTextColor(txtTitle, LOOK.ARTICLEDETAIL_TITLECOLOR, LOOK.GLOBAL_BACKTEXTCOLOR);
            helper.setTextSize(txtTitle, LOOK.ARTICLEDETAIL_TITLESIZE, LOOK.GLOBAL_TITLESIZE);
            helper.setTextStyle(txtTitle, LOOK.ARTICLEDETAIL_TITLESTYLE, LOOK.GLOBAL_TITLESTYLE);
            helper.setTextShadow(txtTitle, LOOK.ARTICLEDETAIL_TITLESHADOWCOLOR, LOOK.GLOBAL_BACKTEXTSHADOWCOLOR,
                    LOOK.ARTICLEDETAIL_TITLESHADOWOFFSET, LOOK.GLOBAL_TITLESHADOWOFFSET);

            TextView txtBody = (TextView)findViewById(R.id.articleDetail_lblBody);
            helper.setTextColor(txtBody, LOOK.ARTICLEDETAIL_TEXTCOLOR, LOOK.GLOBAL_BACKTEXTCOLOR);
            helper.setTextSize(txtBody, LOOK.ARTICLEDETAIL_TEXTSIZE, LOOK.GLOBAL_TEXTSIZE);
            helper.setTextStyle(txtBody, LOOK.ARTICLEDETAIL_TEXTSTYLE, LOOK.GLOBAL_TEXTSTYLE);
            helper.setTextShadow(txtBody, LOOK.ARTICLEDETAIL_TEXTSHADOWCOLOR, LOOK.GLOBAL_BACKTEXTSHADOWCOLOR,
                    LOOK.ARTICLEDETAIL_TEXTSHADOWOFFSET, LOOK.GLOBAL_TEXTSHADOWOFFSET);

            FlexibleButton flxBackButton = (FlexibleButton)findViewById(R.id.articledetail_flxBackButton);
            helper.setViewBackgroundImageOrColor(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONBACKGROUNDIMAGE,
                    LOOK.ARTICLEDETAIL_BACKBUTTONBACKGROUNDCOLOR, LOOK.GLOBAL_ALTCOLOR);
            helper.setFlexibleButtonImage(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONICON);
            helper.setFlexibleButtonTextColor(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONTEXTCOLOR, LOOK.GLOBAL_ALTTEXTCOLOR);
            helper.setFlexibleButtonTextSize(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONTEXTSIZE, LOOK.GLOBAL_ITEMTITLESIZE);
            helper.setFlexibleButtonTextStyle(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONTEXTSTYLE, LOOK.GLOBAL_ITEMTITLESTYLE);
            helper.setFlexibleButtonTextShadow(flxBackButton, LOOK.ARTICLEDETAIL_BACKBUTTONTEXTSHADOWCOLOR, LOOK.GLOBAL_ALTTEXTSHADOWCOLOR,
                    LOOK.ARTICLEDETAIL_BACKBUTTONTEXTSHADOWOFFSET, LOOK.GLOBAL_ITEMTITLESHADOWOFFSET);

        } catch (Exception e) {
            MyLog.e("Exception in ArticleDetailActivity:setAppearance", e);
        }
    }
}