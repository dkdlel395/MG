from flask import render_template, request
from controller import bp_main as main


@main.route('/', methods=['get','post'])
def home():
    return render_template( 'main.html' )
    
