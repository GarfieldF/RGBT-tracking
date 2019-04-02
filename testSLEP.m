m=1000;  n=1000;    % The data matrix is of size m x n

% for reproducibility
randNum=1;

% ---------------------- generate random data ----------------------
randn('state',(randNum-1)*3+1);
A=randn(m,n);       % the data matrix

randn('state',(randNum-1)*3+2);
xOrin=randn(n,1);

randn('state',(randNum-1)*3+3);
noise=randn(m,1);
y=A*xOrin +...
    noise*0.01;     % the response

z=100;               % the radius of the L1 ball

%----------------------- Set optional items -----------------------
opts=[];

% Starting point
opts.init=2;            % starting from a zero point

% Termination criterion
opts.tFlag=5;          % run .maxIter iterations
opts.maxIter=100;      % maximum number of iterations

% Mormalization
opts.nFlag=0;         % without normalization

%opts.rsL2=0.1;        % the two norm regularization

%----------------------- Run the code LeastC -----------------------
fprintf('\n lFlag=0 \n');
opts.lFlag=0;       % Nemirovski's line search
tic;
[x1, funVal1, ValueL1]= LeastC(A, y, z, opts);
toc;

fprintf('\n lFlag=1 \n');
opts.lFlag=1;       % adaptive line search
opts.tFlag=2; opts.tol= funVal1(end);
tic;
[x2, funVal2, ValueL2]= LeastC(A, y, z, opts);
toc;

figure;
plot(funVal1,'-r');
hold on;
plot(funVal2,'--b');
legend('lFlag=0', 'lFlag=1');
xlabel('Iteration (i)');
ylabel('The objective function value');

% --------------------- compute the pathwise solutions ----------------
opts.fName='LeastC';    % set the function name to 'LeastC'
Z=[10, 100, 200, 500];  % set the parameters

% run the function pathSolutionLeast
fprintf('\n Compute the pathwise solutions, please wait...');
X=pathSolutionLeast(A, y, Z, opts);
