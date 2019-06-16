"""My utils."""
import os
import time
import datetime
import re
import logging
import json

from mxnet.symbol import Symbol
from mxboard import SummaryWriter


def makedir(directory):
    """Make directory."""
    if not os.path.isdir(directory):
        os.makedirs(directory)


def time_format(seconds):
    """Get time in format: h:m:s."""
    if seconds > 3600:
        return '%d:%02d:%02d' % (seconds // 3600, (seconds % 3600) // 60, seconds % 60)
    elif seconds > 60:
        return '%d:%02d' % (seconds // 60, seconds % 60)
    return '%ds' % seconds


class Logger(object):
    """Class for logging to file and terminal."""

    def __init__(self, out_dir, log_file, init=True, log_board=False, log_comet=None):
        """Do initial class."""
        makedir(os.path.join(out_dir, 'params/'))
        self.batch_size = 1
        self.max_step = 1
        self.epoch = 1
        self.nbatch = 0
        self.btic = time.time()
        self.etic = time.time()
        if init:
            filehandler = logging.FileHandler(os.path.join(out_dir, log_file), mode='w')
        else:
            filehandler = logging.FileHandler(os.path.join(out_dir, log_file), mode='a')
        streamhandler = logging.StreamHandler()
        # logging.basicConfig()
        logformatter = logging.Formatter("%(asctime)s[%(threadName)s|%(levelname)s] %(message)s", "%H:%M:%S")
        filehandler.setFormatter(logformatter)
        streamhandler.setFormatter(logformatter)
        self.logger = logging.getLogger()
        self.logger.setLevel(logging.INFO)
        if not self.logger.handlers:
            self.logger.addHandler(filehandler)
            self.logger.addHandler(streamhandler)
        self.logger.propagate = False
        if log_board:
            self.logsw = SummaryWriter(logdir=os.path.join(out_dir, 'logs/'))
        else:
            self.logsw = None
        self.log_comet = log_comet

    def start(self, epoch, batch_size, max_step, lr):
        """Start Logger for new epoch."""
        self.epoch = epoch
        self.batch_size = batch_size
        self.num_digit = len(str(max_step))
        self.max_step = max_step
        self.nbatch = 0
        self.logger.info("Start epoch %d with [%d batches - lr: %f] at %s" % (epoch, max_step, lr, datetime.datetime.now().strftime('%Y/%m/%d %H:%M:%S')))
        self.btic = time.time()
        self.etic = time.time()

    def finish(self, message):
        """Log for finish epoch."""
        speed = self.batch_size * self.max_step / (time.time() - self.etic)
        log_message = "[Epoch %d] %4.1f samples/sec - Cost: %s - %s" % (self.epoch, speed, time_format(time.time() - self.etic), message)
        self.logger.info(log_message)

    def write(self, message, step=1):
        """Write message to file and terminal while training."""
        self.nbatch += step
        speed = self.batch_size * step / (time.time() - self.btic)
        eta = (self.max_step - self.nbatch) * self.batch_size / speed
        log_message = "Iter [%d][%%%dd/%%%dd] %4.1f spl - ETA: %s - %s" % (self.epoch, self.num_digit, self.num_digit, speed, time_format(eta), message) % (self.nbatch, self.max_step)
        self.logger.info(log_message)
        self.logger.handlers[0].flush()
        self.btic = time.time()

    def info(self, message):
        """Write message to file and terminal."""
        self.logger.info(message)

    def flush(self):
        """Flush cache to output."""
        # this flush method is needed for python 3 compatibility.
        # this handles the flush command by doing nothing.
        # you might want to specify some extra behavior here.
        pass
