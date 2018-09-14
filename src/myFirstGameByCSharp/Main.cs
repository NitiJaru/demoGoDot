using Godot;
using System;

public class Main : Node
{
    [Export]
    public PackedScene Mob;

    public int Score = 0;

    // Note: We're going to use this many times, so instantiating it
    // allows our numbers to consistently be random.
    private Random rand = new Random();
	
    public override void _Ready()
    {
        // Called every time the node is added to the scene.
        // Initialization here
        
    }
	
    // We'll use this later because C# doesn't support GDScript's randi().
    private float RandRand(float min, float max)
    {
        return (float) (rand.NextDouble() * (max - min) + min);
    }
	
	private void GameOver()
	{
	    //timers
	    var mobTimer = (Timer) GetNode("MobTimer");
	    var scoreTimer = (Timer) GetNode("ScoreTimer");
	
	    scoreTimer.Stop();
	    mobTimer.Stop();
		
		var hud = (HUD) GetNode("HUD");
		hud.ShowGameOver();
		
		var audio = (AudioStreamPlayer) GetNode("BackgroundSound");
		audio.Stop();
		
		var death_audio = (AudioStreamPlayer) GetNode("DeathSound");
		death_audio.Play();
	}
	
	public void NewGame()
	{
	    Score = 0;
	
	    var player = (Player) GetNode("Player");
	    var startTimer = (Timer) GetNode("StartTimer");
	    var startPosition = (Position2D) GetNode("StartPosition");
	
	    player.Start(startPosition.Position);
	    startTimer.Start();
		
		var hud = (HUD) GetNode("HUD");
		hud.UpdateScore(Score);
		hud.ShowMessage("Get Ready!");
	}
	
	private void OnStartTimerTimeout()
	{
	    //timers
	    var mobTimer = (Timer) GetNode("MobTimer");
	    var scoreTimer = (Timer) GetNode("ScoreTimer");
	
	    mobTimer.Start();
	    scoreTimer.Start();
		
		var audio = (AudioStreamPlayer) GetNode("BackgroundSound");
		audio.Play();
	}
	
	private void OnScoreTimerTimeout()
	{
	    Score++;
		
		var hud = (HUD) GetNode("HUD");
		hud.UpdateScore(Score);	
	}
	
	private void OnMobTimerTimeout()
	{
	    // Choose a random location on Path2D.
	    var mobSpawnLocation = (PathFollow2D) GetNode("MobPath/MobSpawnLocation");
	    mobSpawnLocation.SetOffset(rand.Next());
	
	    // Create a Mob instance and add it to the scene.
	    var mobInstance = (RigidBody2D) Mob.Instance();
	    AddChild(mobInstance);
	
	    // Set the mob's direction perpendicular to the path direction.
	    var direction = mobSpawnLocation.Rotation + Mathf.Pi / 2;
	
	    // Set the mob's position to a random location.
	    mobInstance.Position = mobSpawnLocation.Position;
	
	    // Add some randomness to the direction.
	    direction += RandRand(-Mathf.Pi / 4, Mathf.Pi / 4);
	    mobInstance.Rotation = direction;
	
	    // Choose the velocity.
	    mobInstance.SetLinearVelocity(new Vector2(RandRand(150f, 250f), 0).Rotated(direction));
	}
	
	private void OnBackgroundSoundFinished()
	{
	    var audio = (AudioStreamPlayer) GetNode("BackgroundSound");
	    audio.Play();
	}
}
