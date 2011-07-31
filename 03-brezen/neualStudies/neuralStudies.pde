import nn.*;

ArrayList inputs;  // List of training input values
Network nn;        // Neural Network Object

int count;         // Total training interations
Landscape land;    // Solution space
float theta = 0.0; // Angle of rotation
PFont f;           // Font


void setup() {

	size(400,400,P3D);

	// Create a landscape object
	land = new Landscape(10,300,300);
	//println(PFont.list());
	f = createFont("Silkscreen",9,false);
	textMode(SCREEN);

	nn = new Network(2,8);

	// Create a list of 4 training inputs
	inputs = new ArrayList();
	float[] input = new float[2];
	input[0] = 0;
	input[1] = 0;
	inputs.add((float []) input.clone());
	input[0] = 1;
	input[1] = 0;
	inputs.add((float []) input.clone());
	input[0] = 0;
	input[1] = 1;
	inputs.add((float []) input.clone());
	input[0] = 1;
	input[1] =1;
	inputs.add((float []) input.clone());
	
	noSmooth();//smooth();
}



void draw() {

	int trainingIterationsPerFrame = 5;

	for (int i = 0; i < trainingIterationsPerFrame; i++) {
		// Pick a random training input
		int pick = int(random(inputs.size()));
		// Grab that input
		float[] inp = (float[]) inputs.get(pick);
		// Compute XOR
		float known = 1;
		if ((inp[0] == 1.0 && inp[1] == 1.0) || (inp[0] == 0 && inp[1] == 0)) known = 0;
		// Train that sucker!
		float result = nn.train(inp,known);
		count++;
	}

	// Ok, visualize the solution space
	background(175);
	pushMatrix();
	translate(width/2,height/2+20,-160);
	rotateX(PI/3);
	rotateZ(theta);

	// Put a little BOX on screen
	pushMatrix();
	stroke(50);
	noFill();
	translate(-10,-10,0);
	box(280);

	// Draw the landscape
	popMatrix();
	land.calculate(nn);
	land.render();
	theta += 0.001;
	popMatrix();

	// Display overal neural net stats
	networkStatus();

}


void networkStatus() {
	float mse = 0.0;

	textFont(f);
	fill(0);
	text("Your friendly neighborhood neural network solving XOR.",10,20);
	text("Total iterations: " + count,10,30);

	for (int i = 0; i < inputs.size(); i++) {
		float[] inp = (float[]) inputs.get(i);
		float known = 1;
		if ((inp[0] == 1.0 && inp[1] == 1.0) || (inp[0] == 0 && inp[1] == 0)) known = 0;
		float result = nn.feedForward(inp);
		//System.out.println("For: " + inp[0] + " " + inp[1] + ":  " + result);
		mse += (result - known)*(result - known);
	}

	float rmse = sqrt(mse/4.0);
	DecimalFormat df = new DecimalFormat("0.000");
	text("Root mean squared error: " + df.format(rmse), 10,40);

}



public class Connection{

	private Neuron from;     // Connection goes from. . .
	private Neuron to;       // To. . .
	private float weight;   // Weight of the connection. . .

	// Constructor  builds a connection with a random weight
	public Connection(Neuron a_, Neuron b_) {
		from = a_;
		to = b_;
		weight = (float) Math.random()*2-1;
	}

	// In case I want to set the weights manually, using this for testing
	public Connection(Neuron a_, Neuron b_, float w) {
		from = a_;
		to = b_;
		weight = w;
	}

	public Neuron getFrom() {
		return from;
	}

	public Neuron getTo() {
		return to;
	}

	public float getWeight() {
		return weight;
	}

	// Changing the weight of the connection
	public void adjustWeight(float deltaWeight) {
		weight += deltaWeight+random(-100,100)/200.0;
	}


}

class Neuron{
	protected Neuron a,b;
	protected float output;
	protected ArrayList connections;
	protected boolean bias = false;

	public Neuron(){
		output  = 0;
		connections = new ArrayList();
		bias = false;
	}

	public Neuron(int i){
		output = i;
		connections = new ArrayList();
		bias = true;
	}


	// Function to calculate output of this neuron
	// Output is sum of all inputs*weight of connections
	public void calcOutput() {
		if (bias) {
			// do nothing
		} else {
			float sum = 0;
			float bias = 0;
			//System.out.println("Looking through " + connections.size() + " connections");
			for (int i = 0; i < connections.size(); i++) {
				Connection c = (Connection) connections.get(i);
				Neuron from = c.getFrom();
				Neuron to = c.getTo();
				// Is this connection moving forward to us
				// Ignore connections that we send our output to
				if (to == this) {
					// This isn't really necessary
					// But I am treating the bias individually in case I need to at some point
					if (from.bias) {
						bias = from.getOutput()*c.getWeight();
					} else {
						sum += from.getOutput()*c.getWeight();
					}
				}
			}
			// Output is result of sigmoid function
			output = f(bias+sum);
		}
	}

	void addConnection(Connection c) {
		connections.add(c);
	}

	float getOutput() {
		return output;
	}

	// Sigmoid function
	public float f(float x) {
		return 1.0f / (1.0f + (float) Math.exp(-x));
	}

	public ArrayList getConnections() {
		return connections;
	}
}

public class InputNeuron extends Neuron {
	public InputNeuron() {
		super();
	}

	public InputNeuron(int i) {
		super(i);
	}

	public void input(float d) {
		output = d;
	}

}

public class OutputNeuron extends Neuron {
	public OutputNeuron() {
		super();
	}
}

public class HiddenNeuron extends Neuron {

	public HiddenNeuron() {
		super();
	}

	public HiddenNeuron(int i) {
		super(i);
	}

}

public class Network {

	// Layers
	InputNeuron[] input;
	HiddenNeuron[] hidden;
	OutputNeuron output;

	public static final float LEARNING_CONSTANT = 0.5f;

	// Only One output now to start!!! (i can do better, really. . .)
	// Constructor makes the entire network based on number of inputs & number of neurons in hidden layer
	// Only One hidden layer!!!  (fix this dood)

	public Network(int inputs, int hiddentotal) {

		input = new InputNeuron[inputs+1];  // Got to add a bias input
		hidden = new HiddenNeuron[hiddentotal+1];

		// Make input neurons
		for (int i = 0; i < input.length-1; i++) {
			input[i] = new InputNeuron();
		}

		// Make hidden neurons
		for (int i = 0; i < hidden.length-1; i++) {
			hidden[i] = new HiddenNeuron();
		}

		// Make bias neurons
		input[input.length-1] = new InputNeuron(1);
		hidden[hidden.length-1] = new HiddenNeuron(1);

		// Make output neuron
		output = new OutputNeuron();

		// Connect input layer to hidden layer
		for (int i = 0; i < input.length; i++) {
			for (int j = 0; j < hidden.length-1; j++) {
				// Create the connection object and put it in both neurons
				Connection c = new Connection(input[i],hidden[j]);
				input[i].addConnection(c);
				hidden[j].addConnection(c);
			}
		}

		// Connect the hidden layer to the output neuron
		for (int i = 0; i < hidden.length; i++) {
			Connection c = new Connection(hidden[i],output);
			hidden[i].addConnection(c);
			output.addConnection(c);
		}

	}


	public float feedForward(float[] inputVals) {

		// Feed the input with an array of inputs
		for (int i = 0; i < inputVals.length; i++) {
			input[i].input(inputVals[i]);
		}

		// Have the hidden layer calculate its output
		for (int i = 0; i < hidden.length-1; i++) {
			hidden[i].calcOutput();
		}

		// Calculate the output of the output neuron
		output.calcOutput();

		// Return output
		return output.getOutput();
	}

	public float train(float[] inputs, float answer) {
		float result = feedForward(inputs);


		// This is where the error correction all starts
		// Derivative of sigmoid output function * diff between known and guess
		float deltaOutput = result*(1-result) * (answer-result);


		// BACKPROPOGATION
		// This is easier b/c we just have one output
		// Apply Delta to connections between hidden and output
		ArrayList connections = output.getConnections();
		for (int i = 0; i < connections.size(); i++) {
			Connection c = (Connection) connections.get(i);
			Neuron neuron = c.getFrom();
			float output = neuron.getOutput();
			float deltaWeight = output*deltaOutput;
			c.adjustWeight(LEARNING_CONSTANT*deltaWeight);
		}

		// ADJUST HIDDEN WEIGHTS
		for (int i = 0; i < hidden.length; i++) {
			connections = hidden[i].getConnections();
			float sum  = 0;
			// Sum output delta * hidden layer connections (just one output)
			for (int j = 0; j < connections.size(); j++) {
				Connection c = (Connection) connections.get(j);
				// Is this a connection from hidden layer to next layer (output)?
				if (c.getFrom() == hidden[i]) {
					sum += c.getWeight()*deltaOutput;
				}
			}
			// Then adjust the weights coming in based:
			// Above sum * derivative of sigmoid output function for hidden neurons
			for (int j = 0; j < connections.size(); j++) {
				Connection c = (Connection) connections.get(j);
				// Is this a connection from previous layer (input) to hidden layer?
				if (c.getTo() == hidden[i]) {
					float output = hidden[i].getOutput();
					float deltaHidden = output * (1 - output);  // Derivative of sigmoid(x)
					deltaHidden *= sum;   // Would sum for all outputs if more than one output
					Neuron neuron = c.getFrom();
					float deltaWeight = neuron.getOutput()*deltaHidden;
					c.adjustWeight(LEARNING_CONSTANT*deltaWeight);
				}
			}
		}

		return result;
	}
}
