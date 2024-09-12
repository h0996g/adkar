package com.example.adkar

import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.TextView
import androidx.core.app.NotificationCompat
import java.util.*

class CustomNotificationService : Service() {
    private lateinit var windowManager: WindowManager
    private var notificationView: View? = null
    private val CHANNEL_ID = "CustomNotificationChannel"
    private val NOTIFICATION_ID = 1
    private val handler = Handler()
    private lateinit var runnable: Runnable

    private val adkar = listOf(
        "اللَّهُمَّ إنِّي أَسْأَلُكَ الهُدَى وَالتُّقَى، وَالْعَفَافَ وَالْغِنَى",
        "رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ ۖ وَإِلَّا تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ",
        "رَبَّنَا أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَا ۖ إِنَّكَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ",
        "رَّبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ",
        "اللَّهمَّ إنِّي أسألُك أنِّي أَشهَدُ أنَّك أنت اللهُ، لا إلهَ إلَّا أنت، الأحدُ الصمدُ، الذي لم يَلِدْ ولم يولَدْ، ولم يكُنْ له كُفوًا أحدٌ",
        "اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ الهَمِّ والحَزَنِ، والعَجْزِ والكَسَلِ، والبُخْلِ، والجُبْنِ، وضَلَعِ الدَّيْنِ، وغَلَبَةِ الرِّجالِ",
        "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
        "لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ",
        "رَّبِّ زِدْنِي عِلْمًا",
        "اللَّهمَّ إنِّي أسألُك من خيرِ ما أُمِرَتْ بِه وأعوذُ بِك من شرِّ ما أُمِرَت بِه",
        "اللهمَّ إني أسألُك من كل خيرٍ خزائنُه بيدِك، وأعوذُ بك من كل شرٍّ خزائنُه بيدِك",
        "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَصْلِحْ لِي فِي ذُرِّيَّتِي ۖ إِنِّي تُبْتُ إِلَيْكَ وَإِنِّي مِنَ الْمُسْلِمِينَ",
  "رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا",
  "اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ البُخْلِ، وأَعُوذُ بكَ مِنَ الجُبْنِ، وأَعُوذُ بكَ أنْ أُرَدَّ إلى أرْذَلِ العُمُرِ، وأَعُوذُ بكَ مِن فِتْنَةِ الدُّنْيَا -يَعْنِي فِتْنَةَ الدَّجَّالِ- وأَعُوذُ بكَ مِن عَذَابِ القَبْرِ",
  "رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ",
  "رَبِّ هَبْ لِي مِن لَّدُنكَ ذُرِّيَّةً طَيِّبَةً ۖ إِنَّكَ سَمِيعُ الدُّعَاءِ",
  "رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً",
  "قَالَ رَبِّ اشْرَحْ لِي صَدْرِي*وَيَسِّرْ لِي أَمْرِي",
  "اللَّهُمَّ إنِّي أَعُوذُ بكَ مِن زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ",
  "اللَّهمَّ إنِّي أعوذُ بِك من شرِّ ما عَمِلتُ ، ومن شرِّ ما لم أعمَلْ",
  "رَبِّ نَجِّنِي مِنَ الْقَوْمِ الظَّالِمِينَ",
  "رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ",
  "رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ",
  "اللَّهُمَّ اجْعَلْ في قَلْبِي نُورًا، وفي بَصَرِي نُورًا، وفي سَمْعِي نُورًا، وعَنْ يَمِينِي نُورًا، وعَنْ يَسارِي نُورًا، وفَوْقِي نُورًا، وتَحْتي نُورًا، وأَمامِي نُورًا، وخَلْفِي نُورًا، واجْعَلْ لي نُورًا",
  "اللَّهمَّ أحسَنتَ خَلقي فأحسِن خُلُقي",
  "رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ",
  "رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ",
  "رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ",
  "وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ",
  "اللهمَّ احفَظْني بالإسلام قائمًا، واحفَظْني بالإسلام قاعدًا، واحفظْني بالإسلام راقدًا، ولا تُشْمِتْ بي عدوًّا ولا حاسدًا",
  "اللَّهُمَّ أحْيِنِي ما كانَتِ الحَياةُ خَيْرًا لِي، وتَوَفَّنِي إذا كانَتِ الوَفاةُ خَيْرًا لِي",
  "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَدْخِلْنِي بِرَحْمَتِكَ فِي عِبَادِكَ الصَّالِحِينَ",
  "اللَّهُمَّ أعنَّا على شُكْرِكَ وذِكْرِكَ، وحُسنِ عبادتِكَ",
  "اللهمَّ اكفِنِي بحلالِكَ عن حرَامِكَ، وأغْنِنِي بفَضْلِكَ عمَّن سواكَ",
  "رَبَّنَا آتِنَا مِن لَّدُنكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا",
  "اللَّهمَّ إنِّي أعوذُ بِكَ منَ الفقرِ ، والقلَّةِ ، والذِّلَّةِ ، وأعوذُ بِكَ من أن أظلِمَ ، أو أُظلَمَ",
    )

    override fun onCreate() {
        super.onCreate()
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        createNotificationChannel()
    }

 private var repeatInterval: Long = 1800 * 1000 // Default to 30 minutes

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        repeatInterval = intent?.getLongExtra("repeatInterval", 1800 * 1000) ?: 1800 * 1000
        startForeground(NOTIFICATION_ID, createNotification("التطبيق شغال في الخلفية لاظهار الاذكار"))
        startPeriodicNotifications()
        return START_STICKY
    }

    private fun startPeriodicNotifications() {
        runnable = object : Runnable {
            override fun run() {
                val randomAdkar = adkar.random()
                showNotification(randomAdkar)
                handler.postDelayed(this, repeatInterval) // Use the passed interval
            }
        }
        handler.post(runnable) // Start the periodic notifications
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Custom Notification Channel"
            val descriptionText = "Channel for Custom Notifications"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
                description = descriptionText
            }
            val notificationManager: NotificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

private fun createNotification(content: String): Notification {
    val intent = Intent(this, MainActivity::class.java)
    val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE)

    return NotificationCompat.Builder(this, CHANNEL_ID)
        .setContentTitle("")
        .setContentText(content)
        .setSmallIcon(R.drawable.ic_notification)
        .setContentIntent(pendingIntent)
        .setPriority(NotificationCompat.PRIORITY_MIN)
        .setCategory(NotificationCompat.CATEGORY_SERVICE)
        .setOngoing(true)
        .setSilent(true)
        .build()
}

    private fun showNotification(content: String) {
        if (notificationView != null) {
            // Notification already showing, update the content
            notificationView?.findViewById<TextView>(R.id.notification_text)?.text = content
            return
        }

        val inflater = getSystemService(LAYOUT_INFLATER_SERVICE) as LayoutInflater
        notificationView = inflater.inflate(R.layout.custom_notification_layout, null)

        notificationView?.findViewById<TextView>(R.id.notification_text)?.text = content

        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
            PixelFormat.TRANSLUCENT
        )

        params.gravity = Gravity.TOP or Gravity.START
        params.x = 0
        params.y = 100

        notificationView?.setOnClickListener {
            removeNotification()
        }

        try {
            windowManager.addView(notificationView, params)
        } catch (e: Exception) {
            // Handle exception (e.g., permission not granted)
            removeNotification()
        }
    }

    private fun removeNotification() {
        notificationView?.let {
            try {
                windowManager.removeView(it)
            } catch (e: IllegalArgumentException) {
                // View not attached, ignore
            }
            notificationView = null
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacks(runnable) // Stop the handler
        removeNotification()
        stopForeground(true)
    }
}
