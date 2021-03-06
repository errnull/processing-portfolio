//parameters
final int phrase_height = 45;
final int n_love_png = 5;

class Love
{
  float   love_x = random(100, width-100);
  float   love_y = random(100, height-100);
  float fade_counter = 0;
  float speed = random(0.5, 1.5);
  float deg = random(0, 3.14);
  float dy = random(0.1, 0.3);

  void draw()
  {
    // pushMatrix();
    fade_counter = fade_counter+speed;
    if (fade_counter > 100 && abs(sin(fade_counter*0.03)) < 0.01)
    {
      fade_counter = 0;
      love_x = random(100, width-100);
      love_y = random(100, height-100);
      deg = random(0, 3.14);
      dy = random(0.1, 0.3);
    }
    love_y -= dy;
    tint(255, 10+abs(sin(fade_counter*0.03))*100);
    // translate(love_x,love_y);
    // rotate(deg);
    image(love_png, love_x, love_y);
    noTint();
    // popMatrix();
  }
}

class Phrase 
{
  String id;//id of this phrase
  String text;
  Profile profile_;//who sent it

  void setup(String _id, String _txt, String name, String icon_url)
  {
    id = _id; 
    //just part of text
    int idx = _txt.indexOf("//", 40);
    if (idx != -1)
      text = _txt.substring(0, idx); 
    else
      text = _txt;

    if (g_profiles.containsKey(name) )
    {
      profile_ = g_profiles.get(name);
      profile_.post_ ++;
    }
    else
    {
      profile_ = new Profile(name, icon_url);
      g_profiles.put(name, profile_);
    }
  }
  Phrase(String _id, String _txt, String name, String icon_url)
  {
    setup(_id, _txt, name, icon_url);
  }

  String toString()
  {
    return id+delim+text+delim+profile_.name_+delim+profile_.icon_url_;
  }

  Phrase(String fromString)
  {
    String[] list = split(fromString, delim);
    id = list[0];
    text = list[1];
    String name = list[2];
    String icon_url = list[3];
    setup(id, text, name, icon_url);
  }

  void draw(float idx)
  {
    // pushMatrix();
    float x = noise(idx+frameCount*0.001)*width/4;
    float y = idx*phrase_height+20;
    image(profile_.small_, x-10, y+7);
    // translate(x,y);
    fill(profile_.clr_);
    text(profile_.name_+":", x+10, y+0);	
    fill(20, 20, 20, 240);  
    text(text, x+50, y+20);
    // popMatrix();
  }
}

void draw_seperator()
{
  strokeWeight(10);
  noFill();
  stroke(200, 0, 0, 50);
  float h = -45;
  image(line_png, spa+width/2, h);
}

