# Experiment 1
echo "Starting congestion control algorithm experiments"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/Reno --time 20 --maxq 100 --cong reno --qman pfifo_fast
python plot_ping.py -f result/Reno/pingOut.txt -o result/pingReno.png
python plot_queue.py -f result/Reno/q.txt -o result/qReno.png
echo "TCP Reno done"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/Cubic --time 20 --maxq 100 --cong cubic --qman pfifo_fast
python plot_ping.py -f result/Cubic/pingOut.txt -o result/pingCubic.png
python plot_queue.py -f result/Cubic/q.txt -o result/qCubic.png
echo "TCP CUBIC done"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/BBR --time 20 --maxq 100 --cong bbr --qman fq
python plot_ping.py -f result/BBR/pingOut.txt -o result/pingBBR.png
python plot_queue.py -f result/BBR/q.txt -o result/qBBR.png
echo "TCP BBR done"
sleep 5 # sleep for 5s before starting next experiment
#Experiment 2
echo "Starting q size = 20 experiments"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/Reno --time 20 --maxq 20 --cong reno --qman pfifo_fast
python plot_ping.py -f result/Reno/pingOut.txt -o result/pingReno_q20.png
python plot_queue.py -f result/Reno/q.txt -o result/qReno_q20.png
echo "TCP Reno done"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/Cubic --time 20 --maxq 20 --cong cubic --qman pfifo_fast
python plot_ping.py -f result/Cubic/pingOut.txt -o result/pingCubic_q20.png
python plot_queue.py -f result/Cubic/q.txt -o result/qCubic_q20.png
echo "TCP CUBIC done"
sudo python tcp.py --bw-host 1000 --bw-net 2 --delay 50 --dir result/BBR --time 20 --maxq 20 --cong bbr --qman fq
python plot_ping.py -f result/BBR/pingOut.txt -o result/pingBBR_q20.png
python plot_queue.py -f result/BBR/q.txt -o result/qBBR_q20.png
echo "TCP BBR done"
sleep 5 # sleep for 5s before starting next experiment
# Experiment 3
echo "Starting host speed = 100Mbps experiments"
sudo python tcp.py --bw-host 100 --bw-net 2 --delay 50 --dir result/Reno --time 20 --maxq 100 --cong reno --qman pfifo_fast
python plot_ping.py -f result/Reno/pingOut.txt -o result/pingReno_h100.png
python plot_queue.py -f result/Reno/q.txt -o result/qReno_h100.png
echo "TCP Reno done"
sudo python tcp.py --bw-host 100 --bw-net 2 --delay 50 --dir result/Cubic --time 20 --maxq 100 --cong cubic --qman pfifo_fast
python plot_ping.py -f result/Cubic/pingOut.txt -o result/pingCubic_h100.png
python plot_queue.py -f result/Cubic/q.txt -o result/qCubic_h100.png
echo "TCP CUBIC done"
sudo python tcp.py --bw-host 100 --bw-net 2 --delay 50 --dir result/BBR --time 20 --maxq 100 --cong bbr --qman fq
python plot_ping.py -f result/BBR/pingOut.txt -o result/pingBBR_h100.png
python plot_queue.py -f result/BBR/q.txt -o result/qBBR_h100.png
echo "TCP BBR done"
