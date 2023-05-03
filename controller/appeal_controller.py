from flask import render_template, request
from controller import bp_appeal as appeal


@appeal.route('/', methods=['get','post'])
def home():
    return 'appeal'
    
