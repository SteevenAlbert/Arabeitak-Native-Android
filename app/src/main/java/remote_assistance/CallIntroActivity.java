package remote_assistance;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.RadioButton;

import com.wikitude.samples.R;

public class CallIntroActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_call_intro);
        if (!CustomUtilities.checkSelfPermission(this)) {
            ActivityCompat.requestPermissions(this, CustomUtilities.REQUESTED_PERMISSIONS, CustomUtilities.PERMISSION_REQ_ID);
        }
        setupUI();
    }

    public void setupUI() {
        Button joinButton = findViewById(R.id.join);
        joinButton.setOnClickListener((v)->{
                    RadioButton requestAssistance = findViewById(R.id.request_assistance);
                    Intent intent = requestAssistance.isChecked()? new Intent(v.getContext(), ClientActivity.class):new Intent(v.getContext(), AssistantActivity.class);
                    startActivity(intent);
                }
        );
    }
}