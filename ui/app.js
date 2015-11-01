import React, { Component } from 'react';
import { connect } from 'react-redux';
import onKey from 'key-event'
import * as actions from './actions';

class RadioParadise extends Component {
  componentDidMount() {
    const { dispatch } = this.props;

    dispatch(actions.fetch());
    dispatch(actions.play());

    onKey(window, 'space', () => {
      dispatch(actions.toggle());
    })
  }

  render() {
    return (
      <div className="content">
        <ul className="songs">
          {this.props.songs.map(song =>
            <li className="song">{song.artist} - {song.title}</li>
           )}
        </ul>
      </div>
    );
  }
}

export default connect(mapStateToProps)(RadioParadise);

function mapStateToProps(state) {
  return { songs: state.songs, player: state.player };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(Actions, dispatch);
}
