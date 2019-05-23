class DNA {
    private char[] genes;
    private int fitness;

    DNA(String target){
        int len = target.length();
        this.genes = new char[len];

        for(int i=0; i<len; i++)
            genes[i] = randomChar(0);

        this.calculateFitness(target);
    }

    DNA(char[] genes, String target){
        this.genes = genes;
        this.calculateFitness(target);
    }

    char randomChar(int i){
        //ASCI table - <32, 126>:
        if(i==0) return (char)((int)random(32,136));

            // small letters:
        else if(i==1) return (char)((int)random(97,122));

            //letters {a,b,c,d,e}:
        else return (char)((int)random(97,101));
    }
    public void mutate(int maxMutationPoints){
        int locus;
        int n = (int)random(0,maxMutationPoints);
        for(int i=0; i<n; i++){
            locus = (int)random(0,genes.length);
            this.genes[locus] = randomChar(0);
        }
    }

    private void calculateFitness(String target) {
        int fitness = 0;
        for(int i=0; i<target.length(); i++){
            if(genes[i] == target.toCharArray()[i]) fitness++;
        }
        this.fitness = fitness;
    }

    public DNA[] crossover(char[] partner, int crossoverPoints, String target){
        int N = this.genes.length;
        char[] genes1 = new char[N];
        char[] genes2 = new char[N];

        boolean cPoints[] = new boolean[N];
        int cPoint;

        for(int i=0; i<crossoverPoints; i++){
            cPoint = (int)random(0,N);
            if(cPoints[cPoint]) i--;
            else cPoints[cPoint] = true;
        }

        boolean parentSwitch = true;

        for(int i=0; i<this.genes.length; i++){

            if(parentSwitch){
                genes1[i] = this.genes[i];
                genes2[i] = partner[i];
            }
            else {
                genes1[i] = partner[i];
                genes2[i] = this.genes[i];
            }
            if (cPoints[i] == true) parentSwitch = !parentSwitch;
        }
        DNA[] children = {new DNA(genes1, target), new DNA(genes2, target)};
        return children;
    }

    //overriding the toString() method
    public String toString(){
        return new String(genes);
    }

    //--------- getters ----------------------

    public int getFitness(){
        return this.fitness;
    }

    public char[] getGenes(){
        return this.genes;
    }

}
